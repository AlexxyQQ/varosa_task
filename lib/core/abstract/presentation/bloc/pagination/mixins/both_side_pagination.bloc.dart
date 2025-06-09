import 'dart:developer';

import '../pagination.bloc.dart';

/// Mixin that provides both-side pagination functionality
///
/// **Important**: This mixin should ONLY be used with offset-based pagination.
/// Cursor-based pagination inherently doesn't support bidirectional navigation
/// due to the nature of cursor tokens.
///
/// **Usage**:
/// ```dart
/// class MyPaginationBloc extends PaginationBloc<MyItem>
///     with BothSidePaginationBloc<MyItem> {
///   MyPaginationBloc() : super(useCursorPagination: false); // Must be false
/// }
/// ```
///
/// **Features for offset-based pagination**:
/// - Load next/previous pages
/// - Jump to specific pages
/// - Bidirectional pagination controls
/// - Page size management for both directions
///
/// **Restrictions for cursor-based pagination**:
/// - Previous page loading is disabled
/// - Page jumping is not available
/// - Page size for previous direction is ignored
mixin BothSidePaginationBloc<T> on PaginationBloc<T> {
  // =================== Navigation Methods ===================

  /// Loads the next page of data if available
  ///
  /// Available for both cursor-based and offset-based pagination.
  void loadNext() {
    if (canLoadNext) {
      add(const LoadNextPaginationEvent());
    }
  }

  /// Loads the previous page of data if available
  ///
  /// **Note**: Only available for offset-based pagination.
  /// For cursor-based pagination, this method will be ignored.
  void loadPrevious() {
    if (useCursorPagination) {
      log(
        'loadPrevious() ignored: Not supported for cursor-based pagination',
        name: 'BothSidePaginationBloc',
      );
      return;
    }

    if (canLoadPrevious) {
      add(const LoadPreviousPaginationEvent());
    }
  }

  /// Loads both next and previous pages simultaneously
  ///
  /// For cursor-based pagination, only loads the next page.
  void loadBothSides() {
    if (canLoadNext) loadNext();
    if (!useCursorPagination && canLoadPrevious) loadPrevious();
  }

  // =================== Page Size Management ===================

  /// Sets the page size for next pagination
  ///
  /// Available for both pagination types.
  void setNextPageSize(int size, {bool refresh = false}) {
    if (size > 0 && size != state.nextPageSize) {
      add(SetNextPageSizeEvent(size, refresh: refresh));
    }
  }

  /// Sets the page size for previous pagination
  ///
  /// **Note**: Only available for offset-based pagination.
  /// For cursor-based pagination, this method will be ignored.
  void setPreviousPageSize(int size, {bool refresh = false}) {
    if (useCursorPagination) {
      log(
        'setPreviousPageSize() ignored: Not supported for cursor-based pagination',
        name: 'BothSidePaginationBloc',
      );
      return;
    }

    if (size > 0 && size != state.previousPageSize) {
      add(SetPreviousPageSizeEvent(size, refresh: refresh));
    }
  }

  // =================== Navigation Control ===================

  /// Resets pagination to the initial state
  ///
  /// Available for both pagination types.
  void resetPagination({bool keepFilters = true}) {
    add(ResetPaginationEvent(keepFilters: keepFilters));
  }

  /// Jump to a specific page (offset-based pagination only)
  ///
  /// **Note**: Only available for offset-based pagination.
  /// For cursor-based pagination, this method will be ignored.
  void jumpToPage(int page) {
    if (useCursorPagination) {
      log(
        'jumpToPage() ignored: Not supported for cursor-based pagination',
        name: 'BothSidePaginationBloc',
      );
      return;
    }

    if (page > 0 && page != state.currentPage) {
      add(JumpToPageEvent(page));
    }
  }

  // =================== State Getters ===================

  /// Whether more data can be loaded in the next direction
  ///
  /// Available for both pagination types.
  bool get canLoadNext => !state.hasReachedNextEnd && !state.isLoadingNext;

  /// Whether more data can be loaded in the previous direction
  ///
  /// **Note**: Always returns false for cursor-based pagination.
  bool get canLoadPrevious {
    if (useCursorPagination) return false;

    return !state.hasReachedPreviousEnd &&
        !state.isLoadingPrevious &&
        state.currentPage > 1;
  }

  /// Whether pagination is currently loading in any direction
  bool get isLoadingAnyDirection =>
      state.isLoading || state.isLoadingNext || state.isLoadingPrevious;

  /// Whether pagination has loaded data in the next direction
  bool get hasLoadedNext => state.hasLoadedNext;

  /// Whether pagination has loaded data in the previous direction
  ///
  /// **Note**: Always returns false for cursor-based pagination.
  bool get hasLoadedPrevious =>
      useCursorPagination ? false : state.hasLoadedPrevious;

  /// Whether pagination has reached the end in both directions
  ///
  /// For cursor-based pagination, only checks the next direction.
  bool get hasReachedBothEnds {
    if (useCursorPagination) {
      return state.hasReachedNextEnd;
    }
    return state.hasReachedNextEnd && state.hasReachedPreviousEnd;
  }

  // =================== Pagination Info ===================

  /// Current page number
  ///
  /// **Note**: For cursor-based pagination, this represents the logical page
  /// but page numbers aren't used for navigation.
  int get currentPage => state.currentPage;

  /// Total number of items currently loaded
  int get totalItemsCount => state.items.length;

  /// Whether there are any items loaded
  bool get hasItems => state.items.isNotEmpty;

  /// Whether pagination is in an error state
  bool get hasError => state.error != null;

  /// Current error message if any
  String? get errorMessage => state.error?.message;

  // =================== Cursor Pagination Helpers ===================

  /// Current next token for cursor-based pagination
  ///
  /// **Note**: Only relevant for cursor-based pagination.
  String? get nextToken => state.nextToken;

  /// Current previous token for cursor-based pagination
  ///
  /// **Note**: Only relevant for cursor-based pagination, but previous
  /// navigation is not supported.
  String? get previousToken => state.previousToken;

  /// Whether using cursor-based pagination
  bool get isCursorPagination => useCursorPagination;

  /// Whether using offset-based pagination (supports both-side navigation)
  bool get isOffsetPagination => !useCursorPagination;

  // =================== Validation ===================

  /// Validates that both-side pagination is properly configured
  ///
  /// Logs warnings if cursor-based pagination is detected, as it limits
  /// the functionality of this mixin.
  void validateConfiguration() {
    if (useCursorPagination) {
      log(
        'Warning: BothSidePaginationBloc used with cursor-based pagination. '
        'Previous navigation, page jumping, and previous page size are disabled.',
        name: 'BothSidePaginationBloc',
      );
    }
  }

  @override
  void dispose() {
    try {
      // Cleanup specific to both-side pagination if needed
    } catch (e) {
      log(
        'BothSidePaginationBloc dispose error: $e',
        name: 'BothSidePaginationBloc',
      );
    }
    super.dispose();
  }
}
