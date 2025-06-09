import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/data/models/error/app_error.model.dart';
import '../../../../common/presentation/helpers/debounce.helper.dart';

part 'pagination.event.dart';
part 'pagination.state.dart';
part 'pagination.bloc.freezed.dart';

/// Response model for pagination data
///
/// Contains the fetched items and pagination metadata
class PaginationResponse<T> {
  /// List of items for the current page/request
  final List<T> items;

  /// Token for next page (cursor-based pagination)
  final String? nextToken;

  /// Token for previous page (cursor-based pagination)
  final String? previousToken;

  /// Next page number (offset-based pagination)
  final int? nextPage;

  /// Total number of pages (if available)
  final int? totalPages;

  /// Whether pagination has reached the end (no more items to load next)
  final bool hasReachedEnd;

  /// Whether pagination has reached the start (no more items to load previous)
  final bool hasReachedStart;

  /// Total count of items (optional, useful for offset-based pagination)
  final int? totalCount;

  const PaginationResponse({
    required this.items,
    this.nextToken,
    this.previousToken,
    this.nextPage,
    this.totalPages,
    this.hasReachedEnd = false,
    this.hasReachedStart = false,
    this.totalCount,
  });
}

/// Abstract base class for pagination functionality
///
/// Supports both cursor-based and offset-based pagination patterns.
/// - **Cursor-based**: Uses tokens for navigation, only supports forward pagination
/// - **Offset-based**: Uses page numbers, supports bidirectional pagination
abstract class PaginationBloc<T>
    extends Bloc<PaginationEvent, PaginationState<T>> {
  /// Whether to use cursor-based pagination instead of offset-based
  final bool useCursorPagination;

  /// Helper for debouncing filter updates
  final DebouncerHelper _debounceHelper = DebouncerHelper(
    duration: const Duration(milliseconds: 300),
  );

  /// Creates a pagination bloc
  ///
  /// [useCursorPagination]: If true, uses cursor-based pagination (forward-only).
  /// If false, uses offset-based pagination (bidirectional).
  PaginationBloc({this.useCursorPagination = false})
    : super(PaginationState<T>.initial()) {
    _registerEventHandlers();
  }

  /// Registers all event handlers
  void _registerEventHandlers() {
    on<LoadInitialPaginationEvent>(_onLoadInitial);
    on<LoadNextPaginationEvent>(_onLoadNext);
    on<LoadPreviousPaginationEvent>(_onLoadPrevious);
    on<RefreshPaginationEvent>(_onRefresh);
    on<UpdateFiltersPaginationEvent>(_onUpdateFilters);
    on<RefetchFetchDataEvent>(_onRefetch);
    on<SetNextPageSizeEvent>(_onSetNextPageSize);
    on<SetPreviousPageSizeEvent>(_onSetPreviousPageSize);
    on<JumpToPageEvent>(_onJumpToPage);
    on<ResetPaginationEvent>(_onResetPagination);
  }

  /// Abstract method to fetch items from the data source
  ///
  /// Implementations should handle the specific API calls and data fetching logic.
  ///
  /// For **cursor-based pagination**:
  /// - Use [nextToken] or [previousToken] for navigation
  /// - [page] should be null
  ///
  /// For **offset-based pagination**:
  /// - Use [page] for navigation
  /// - Tokens should be null
  Future<Either<AppErrorModel, PaginationResponse<T>>> fetchItems({
    int? page,
    int? limit,
    String? nextToken,
    String? previousToken,
    Map<String, dynamic>? filters,
  });

  /// Handles initial data loading
  Future<void> _onLoadInitial(
    LoadInitialPaginationEvent event,
    Emitter<PaginationState<T>> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        error: null,
        items: [],
        currentPage: 1,
        nextToken: null,
        previousToken: null,
        nextPage: null,
        totalPages: null,
        hasReachedNextEnd: false,
        hasReachedPreviousEnd: true, // Cursor pagination starts at beginning
      ),
    );

    final result = await fetchItems(
      page: useCursorPagination ? null : 1,
      limit: event.limit ?? state.nextPageSize,
      filters: state.filters,
    );

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, error: error)),
      (response) {
        final nextPage = _calculateNextPage(response, 1);
        final totalPages = _calculateTotalPages(
          response,
          event.limit ?? state.nextPageSize,
        );

        emit(
          state.copyWith(
            isLoading: false,
            items: response.items,
            nextToken: response.nextToken,
            previousToken: response.previousToken,
            nextPage: nextPage,
            totalPages: totalPages,
            hasReachedNextEnd: response.hasReachedEnd,
            hasReachedPreviousEnd: response.hasReachedStart,
            hasLoadedNext: false,
            hasLoadedPrevious: false,
          ),
        );
      },
    );
  }

  /// Handles loading next page of data
  Future<void> _onLoadNext(
    LoadNextPaginationEvent event,
    Emitter<PaginationState<T>> emit,
  ) async {
    if (state.hasReachedNextEnd || state.isLoadingNext) return;

    emit(state.copyWith(isLoadingNext: true, error: null));

    final result = await fetchItems(
      page: useCursorPagination ? null : state.currentPage + 1,
      limit: state.nextPageSize,
      nextToken: useCursorPagination ? state.nextToken : null,
      filters: state.filters,
    );

    result.fold(
      (error) => emit(state.copyWith(isLoadingNext: false, error: error)),
      (response) {
        final newCurrentPage = useCursorPagination
            ? state.currentPage
            : state.currentPage + 1;
        final nextPage = _calculateNextPage(response, newCurrentPage);
        final totalPages = _calculateTotalPages(response, state.nextPageSize);

        emit(
          state.copyWith(
            isLoadingNext: false,
            items: [...state.items, ...response.items],
            currentPage: newCurrentPage,
            nextToken: response.nextToken,
            previousToken: response.previousToken,
            nextPage: nextPage,
            totalPages: totalPages,
            hasReachedNextEnd: response.hasReachedEnd,
            hasLoadedNext: true,
          ),
        );
      },
    );
  }

  /// Handles loading previous page of data
  ///
  /// **Note**: Only available for offset-based pagination.
  /// Cursor-based pagination doesn't support previous page loading.
  Future<void> _onLoadPrevious(
    LoadPreviousPaginationEvent event,
    Emitter<PaginationState<T>> emit,
  ) async {
    // Restrict previous loading for cursor-based pagination
    if (useCursorPagination) {
      log(
        'Previous loading not supported for cursor-based pagination',
        name: 'PaginationBloc',
      );
      return;
    }

    if (state.hasReachedPreviousEnd ||
        state.isLoadingPrevious ||
        state.currentPage <= 1) {
      return;
    }

    emit(state.copyWith(isLoadingPrevious: true, error: null));

    final result = await fetchItems(
      page: state.currentPage - 1,
      limit: state.previousPageSize,
      filters: state.filters,
    );

    result.fold(
      (error) => emit(state.copyWith(isLoadingPrevious: false, error: error)),
      (response) {
        final newCurrentPage = state.currentPage - 1;
        final nextPage = _calculateNextPage(response, newCurrentPage);
        final totalPages = _calculateTotalPages(
          response,
          state.previousPageSize,
        );

        emit(
          state.copyWith(
            isLoadingPrevious: false,
            items: [...response.items, ...state.items],
            currentPage: newCurrentPage,
            nextToken: response.nextToken,
            previousToken: response.previousToken,
            nextPage: nextPage,
            totalPages: totalPages,
            hasReachedPreviousEnd: response.hasReachedStart,
            hasLoadedPrevious: true,
          ),
        );
      },
    );
  }

  /// Handles pagination refresh (resets to initial state)
  Future<void> _onRefresh(
    RefreshPaginationEvent event,
    Emitter<PaginationState<T>> emit,
  ) async {
    emit(
      PaginationState<T>.initial().copyWith(
        filters: state.filters,
        nextPageSize: state.nextPageSize,
        previousPageSize: state.previousPageSize,
      ),
    );
    add(LoadInitialPaginationEvent(limit: state.nextPageSize));
  }

  /// Handles filter updates with debouncing
  Future<void> _onUpdateFilters(
    UpdateFiltersPaginationEvent event,
    Emitter<PaginationState<T>> emit,
  ) async {
    _debounceHelper(() async {
      emit(state.copyWith(filters: event.filters));

      if (event.refresh == true) {
        add(const RefreshPaginationEvent());
      } else {
        add(LoadInitialPaginationEvent(limit: state.nextPageSize));
      }
    });
  }

  /// Handles data refetch (maintains current position)
  Future<void> _onRefetch(
    RefetchFetchDataEvent event,
    Emitter<PaginationState<T>> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await fetchItems(
      page: useCursorPagination ? null : state.currentPage,
      limit: state.nextPageSize,
      nextToken: useCursorPagination ? state.nextToken : null,
      previousToken: useCursorPagination ? state.previousToken : null,
      filters: state.filters,
    );

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, error: error)),
      (response) {
        final nextPage = _calculateNextPage(response, state.currentPage);
        final totalPages = _calculateTotalPages(response, state.nextPageSize);

        emit(
          state.copyWith(
            isLoading: false,
            items: response.items,
            nextToken: response.nextToken,
            previousToken: response.previousToken,
            nextPage: nextPage,
            totalPages: totalPages,
            hasReachedNextEnd: response.hasReachedEnd,
            hasReachedPreviousEnd: response.hasReachedStart,
          ),
        );
      },
    );
  }

  /// Handles next page size updates
  Future<void> _onSetNextPageSize(
    SetNextPageSizeEvent event,
    Emitter<PaginationState<T>> emit,
  ) async {
    emit(state.copyWith(nextPageSize: event.pageSize));

    if (event.refresh) {
      add(const RefreshPaginationEvent());
    }
  }

  /// Handles previous page size updates
  Future<void> _onSetPreviousPageSize(
    SetPreviousPageSizeEvent event,
    Emitter<PaginationState<T>> emit,
  ) async {
    // Previous page size only relevant for offset-based pagination
    if (useCursorPagination) return;

    emit(state.copyWith(previousPageSize: event.pageSize));

    if (event.refresh) {
      add(const RefreshPaginationEvent());
    }
  }

  /// Handles page jumping (offset-based pagination only)
  Future<void> _onJumpToPage(
    JumpToPageEvent event,
    Emitter<PaginationState<T>> emit,
  ) async {
    if (useCursorPagination || event.page < 1) {
      log(
        'Page jumping not supported for cursor-based pagination',
        name: 'PaginationBloc',
      );
      return;
    }

    emit(state.copyWith(isLoading: true, error: null, currentPage: event.page));

    final result = await fetchItems(
      page: event.page,
      limit: state.nextPageSize,
      filters: state.filters,
    );

    result.fold(
      (error) => emit(
        state.copyWith(
          isLoading: false,
          error: error,
          currentPage: state.currentPage, // Revert page on error
        ),
      ),
      (response) {
        final nextPage = _calculateNextPage(response, event.page);
        final totalPages = _calculateTotalPages(response, state.nextPageSize);

        emit(
          state.copyWith(
            isLoading: false,
            items: response.items,
            nextToken: response.nextToken,
            previousToken: response.previousToken,
            nextPage: nextPage,
            totalPages: totalPages,
            hasReachedNextEnd: response.hasReachedEnd,
            hasReachedPreviousEnd: response.hasReachedStart,
            hasLoadedNext: false,
            hasLoadedPrevious: false,
          ),
        );
      },
    );
  }

  /// Handles pagination reset
  Future<void> _onResetPagination(
    ResetPaginationEvent event,
    Emitter<PaginationState<T>> emit,
  ) async {
    final filtersToKeep = event.keepFilters ? state.filters : null;

    emit(
      PaginationState<T>.initial().copyWith(
        filters: filtersToKeep,
        nextPageSize: state.nextPageSize,
        previousPageSize: state.previousPageSize,
      ),
    );

    add(LoadInitialPaginationEvent(limit: state.nextPageSize));
  }

  @override
  Future<void> close() {
    dispose();
    return super.close();
  }

  /// Dispose resources when bloc is closed
  void dispose() {
    _debounceHelper.dispose();
    // Override in subclasses if additional cleanup is needed
  }

  /// Calculates the next page number if not provided by the API
  int? _calculateNextPage(PaginationResponse<T> response, int currentPage) {
    // If API provides nextPage, use it
    if (response.nextPage != null) {
      return response.nextPage;
    }

    // For cursor-based pagination, we don't calculate page numbers
    if (useCursorPagination) {
      return null;
    }

    // For offset-based pagination, calculate based on hasReachedEnd
    if (response.hasReachedEnd) {
      return null;
    }

    return currentPage + 1;
  }

  /// Calculates total pages if not provided by the API
  int? _calculateTotalPages(PaginationResponse<T> response, int pageSize) {
    // If API provides totalPages, use it
    if (response.totalPages != null) {
      return response.totalPages;
    }

    // If we have totalCount, calculate totalPages
    if (response.totalCount != null && pageSize > 0) {
      return (response.totalCount! / pageSize).ceil();
    }

    // For cursor-based pagination or when totalCount is not available
    return null;
  }
}
