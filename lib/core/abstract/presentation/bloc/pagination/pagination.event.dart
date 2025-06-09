part of 'pagination.bloc.dart';

abstract class PaginationEvent extends Equatable {
  const PaginationEvent();

  @override
  List<Object?> get props => [];
}

// Loads the first data
class LoadInitialPaginationEvent extends PaginationEvent {
  final int? limit;

  const LoadInitialPaginationEvent({this.limit});

  @override
  List<Object?> get props => [limit];
}

// Loads the next data (according to the limit and page or nextToken)
class LoadNextPaginationEvent extends PaginationEvent {
  const LoadNextPaginationEvent();
}

// Loads the previous data (according to the limit and page or nextToken)
class LoadPreviousPaginationEvent extends PaginationEvent {
  const LoadPreviousPaginationEvent();
}

// Refreshes the data (Does not keep the applied filters and the current page or nextToken)
class RefreshPaginationEvent extends PaginationEvent {
  const RefreshPaginationEvent();

  @override
  List<Object?> get props => [];
}

// Updates the filters (Keeps the current page or nextToken), and if refresh is true, it will reset the current page or nextToken
class UpdateFiltersPaginationEvent extends PaginationEvent {
  final Map<String, dynamic> filters;
  final bool? refresh;

  const UpdateFiltersPaginationEvent(this.filters, {this.refresh = false});

  @override
  List<Object?> get props => [filters, refresh];
}

// Refetches the data (Keep the applied filters and the current page or nextToken)
class RefetchFetchDataEvent extends PaginationEvent {
  const RefetchFetchDataEvent();

  @override
  List<Object?> get props => [];
}

// Sets the page size for next pagination
class SetNextPageSizeEvent extends PaginationEvent {
  final int pageSize;
  final bool refresh;

  const SetNextPageSizeEvent(this.pageSize, {this.refresh = false});

  @override
  List<Object?> get props => [pageSize, refresh];
}

// Sets the page size for previous pagination
class SetPreviousPageSizeEvent extends PaginationEvent {
  final int pageSize;
  final bool refresh;

  const SetPreviousPageSizeEvent(this.pageSize, {this.refresh = false});

  @override
  List<Object?> get props => [pageSize, refresh];
}

// Jumps to a specific page (for offset-based pagination only)
class JumpToPageEvent extends PaginationEvent {
  final int page;

  const JumpToPageEvent(this.page);

  @override
  List<Object?> get props => [page];
}

// Resets pagination to initial state keeping filters
class ResetPaginationEvent extends PaginationEvent {
  final bool keepFilters;

  const ResetPaginationEvent({this.keepFilters = true});

  @override
  List<Object?> get props => [keepFilters];
}
