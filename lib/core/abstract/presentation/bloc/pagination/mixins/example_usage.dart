// Example usage of the pagination system
// This file shows how to implement and use the various pagination mixins

import 'package:fpdart/fpdart.dart';

import '../../../../../common/data/models/error/app_error.model.dart';
import '../pagination.bloc.dart';
import 'both_side_pagination.bloc.dart';
import 'filterable_pagination.bloc.dart';
import 'searchable_pagination.bloc.dart';

// Example data model
class ExampleItem {
  final String id;
  final String name;
  final String description;

  ExampleItem({
    required this.id,
    required this.name,
    required this.description,
  });
}

// Example 1: Basic pagination
class BasicPaginationBloc extends PaginationBloc<ExampleItem> {
  BasicPaginationBloc() : super(useCursorPagination: false);

  @override
  Future<Either<AppErrorModel, PaginationResponse<ExampleItem>>> fetchItems({
    int? page,
    int? limit,
    String? nextToken,
    String? previousToken,
    Map<String, dynamic>? filters,
  }) async {
    // Your API call implementation here
    // Return Either.left(error) for errors
    // Return Either.right(PaginationResponse(...)) for success

    // Example implementation:
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Simulate API call

    return Right(
      PaginationResponse<ExampleItem>(
        items: [
          ExampleItem(id: '1', name: 'Item 1', description: 'Description 1'),
          ExampleItem(id: '2', name: 'Item 2', description: 'Description 2'),
        ],
        hasReachedEnd: page! >= 10, // Example: 10 pages total
        hasReachedStart: page <= 1,
      ),
    );
  }
}

// Example 2: Pagination with search functionality
class SearchablePaginationExample extends PaginationBloc<ExampleItem>
    with SearchablePaginationBloc<ExampleItem> {
  SearchablePaginationExample() : super(useCursorPagination: false) {
    // Initialize search functionality
    initializeSearch();
  }

  @override
  Future<Either<AppErrorModel, PaginationResponse<ExampleItem>>> fetchItems({
    int? page,
    int? limit,
    String? nextToken,
    String? previousToken,
    Map<String, dynamic>? filters,
  }) async {
    // Handle search filter
    final searchQuery = filters?['search'] as String?;

    // Your API call with search implementation
    // ...

    return const Right(
      PaginationResponse<ExampleItem>(
        items: [
          // Filtered items based on search
        ],
        hasReachedEnd: true,
        hasReachedStart: true,
      ),
    );
  }
}

// Example 3: Pagination with general filtering
class FilterablePaginationExample extends PaginationBloc<ExampleItem>
    with FilterablePaginationBloc<ExampleItem> {
  FilterablePaginationExample() : super(useCursorPagination: false);

  @override
  Future<Either<AppErrorModel, PaginationResponse<ExampleItem>>> fetchItems({
    int? page,
    int? limit,
    String? nextToken,
    String? previousToken,
    Map<String, dynamic>? filters,
  }) async {
    // Handle various filters
    final category = filters?['category'] as String?;
    final status = filters?['status'] as String?;
    final dateRange = filters?['dateRange'] as Map<String, dynamic>?;

    // Your API call with filters implementation
    // ...

    return const Right(
      PaginationResponse<ExampleItem>(
        items: [
          // Filtered items
        ],
        hasReachedEnd: true,
        hasReachedStart: true,
      ),
    );
  }
}

// Example 4: Full-featured pagination with all mixins
class FullFeaturedPaginationExample extends PaginationBloc<ExampleItem>
    with
        SearchablePaginationBloc<ExampleItem>,
        FilterablePaginationBloc<ExampleItem>,
        BothSidePaginationBloc<ExampleItem> {
  FullFeaturedPaginationExample() : super(useCursorPagination: false) {
    // Initialize search functionality
    initializeSearch();
  }

  @override
  Future<Either<AppErrorModel, PaginationResponse<ExampleItem>>> fetchItems({
    int? page,
    int? limit,
    String? nextToken,
    String? previousToken,
    Map<String, dynamic>? filters,
  }) async {
    // Handle all types of filters and pagination
    final searchQuery = filters?['search'] as String?;
    final category = filters?['category'] as String?;
    final status = filters?['status'] as String?;

    // Your comprehensive API call implementation
    // ...

    return Right(
      PaginationResponse<ExampleItem>(
        items: [
          // Your filtered and paginated items
        ],
        hasReachedEnd: page! >= 10,
        hasReachedStart: page <= 1,
      ),
    );
  }
}

// Example 5: Cursor-based pagination
class CursorPaginationExample extends PaginationBloc<ExampleItem>
    with BothSidePaginationBloc<ExampleItem> {
  CursorPaginationExample() : super(useCursorPagination: true);

  @override
  Future<Either<AppErrorModel, PaginationResponse<ExampleItem>>> fetchItems({
    int? page,
    int? limit,
    String? nextToken,
    String? previousToken,
    Map<String, dynamic>? filters,
  }) async {
    // Handle cursor-based pagination
    // Use nextToken and previousToken instead of page numbers

    // Your cursor-based API call implementation
    // ...

    return const Right(
      PaginationResponse<ExampleItem>(
        items: [
          // Your items
        ],
        nextToken: 'next_cursor_token',
        previousToken: 'previous_cursor_token',
      ),
    );
  }
}

/*
Usage Examples in UI:

1. Basic Usage:
   ```dart
   class MyScreen extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return BlocProvider(
         create: (context) => BasicPaginationBloc()
           ..add(const LoadInitialPaginationEvent()),
         child: BlocBuilder<BasicPaginationBloc, PaginationState<ExampleItem>>(
           builder: (context, state) {
             if (state.isLoading && state.items.isEmpty) {
               return const CircularProgressIndicator();
             }
             
             return ListView.builder(
               itemCount: state.items.length + (state.hasReachedNextEnd ? 0 : 1),
               itemBuilder: (context, index) {
                 if (index == state.items.length) {
                   // Load more button or loading indicator
                   if (state.isLoadingNext) {
                     return const CircularProgressIndicator();
                   } else {
                     return ElevatedButton(
                       onPressed: () => context.read<BasicPaginationBloc>()
                         .add(const LoadNextPaginationEvent()),
                       child: const Text('Load More'),
                     );
                   }
                 }
                 
                 final item = state.items[index];
                 return ListTile(
                   title: Text(item.name),
                   subtitle: Text(item.description),
                 );
               },
             );
           },
         ),
       );
     }
   }
   ```

2. With Search:
   ```dart
   BlocProvider(
     create: (context) => SearchablePaginationExample()
       ..add(const LoadInitialPaginationEvent()),
     child: Column(
       children: [
         TextField(
           controller: context.read<SearchablePaginationExample>().searchController,
           decoration: const InputDecoration(hintText: 'Search...'),
         ),
         Expanded(
           child: BlocBuilder<SearchablePaginationExample, PaginationState<ExampleItem>>(
             builder: (context, state) {
               // Your list implementation
             },
           ),
         ),
       ],
     ),
   )
   ```

3. With Filters:
   ```dart
   final bloc = context.read<FilterablePaginationExample>();
   
   // Set a single filter
   bloc.updateFilter('category', 'electronics');
   
   // Set multiple filters
   bloc.updateFilters({
     'status': 'active',
     'category': 'electronics',
     'price_range': {'min': 10, 'max': 100},
   });
   
   // Clear specific filter
   bloc.removeFilter('category');
   
   // Clear all filters
   bloc.clearAllFilters();
   ```

4. Both-side pagination:
   ```dart
   final bloc = context.read<FullFeaturedPaginationExample>();
   
   // Load next page
   bloc.loadNext();
   
   // Load previous page
   bloc.loadPrevious();
   
   // Jump to specific page (offset-based only)
   bloc.jumpToPage(5);
   
   // Set page sizes
   bloc.setNextPageSize(20, refresh: true);
   bloc.setPreviousPageSize(10);
   
   // Check pagination state
   if (bloc.canLoadNext) {
     // Can load more items
   }
   
   if (bloc.hasError) {
     // Handle error: bloc.errorMessage
   }
   ```
*/
