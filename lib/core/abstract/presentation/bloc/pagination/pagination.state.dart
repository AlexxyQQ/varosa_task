part of 'pagination.bloc.dart';

@freezed
abstract class PaginationState<T> with _$PaginationState<T> {
  const PaginationState._();

  const factory PaginationState({
    @Default(false) bool isLoading,
    @Default(false) bool hasLoadedNext,
    @Default(false) bool hasLoadedPrevious,
    @Default(false) bool isLoadingNext,
    @Default(false) bool isLoadingPrevious,
    @Default(false) bool hasReachedNextEnd,
    @Default(false) bool hasReachedPreviousEnd,
    @Default([]) List<T> items,
    @Default(1) int currentPage,
    @Default(10) int nextPageSize,
    @Default(10) int previousPageSize,
    String? nextToken,
    String? previousToken,
    int? nextPage,
    int? totalPages,
    Map<String, dynamic>? filters,
    AppErrorModel? error,
  }) = _PaginationState;

  factory PaginationState.initial() => PaginationState<T>();

  factory PaginationState.error(AppErrorModel error) =>
      PaginationState<T>(error: error);
}
