# 📄 Pagination System Documentation

A comprehensive, reusable pagination system built with Flutter BLoC pattern, supporting both offset-based and cursor-based pagination with various mixins for search, filtering, and bidirectional loading capabilities.

## 🚀 Features

- ✅ **Dual Pagination Support**: Both offset-based (page numbers) and cursor-based (tokens)
- ✅ **Bidirectional Loading**: Load both next and previous pages
- ✅ **Smart Search**: Built-in search with automatic debouncing
- ✅ **Advanced Filtering**: Dynamic filter management with easy add/remove operations
- ✅ **Error Handling**: Comprehensive error state management
- ✅ **Loading States**: Granular loading states (initial, next, previous)
- ✅ **End Detection**: Automatic detection of pagination boundaries
- ✅ **State Persistence**: Maintains pagination state across rebuilds

## 📋 Table of Contents

- [Quick Start](#quick-start)
- [Architecture Overview](#architecture-overview)
- [State Management](#state-management)
- [Events Documentation](#events-documentation)
- [Mixins & Extensions](#mixins--extensions)
- [Implementation Examples](#implementation-examples)
- [UI Integration](#ui-integration)
- [Best Practices](#best-practices)

## 🚀 Quick Start

### 1. Basic Implementation

```dart
class MyItemBloc extends PaginationBloc<MyItem> {
  MyItemBloc() : super(useCursorPagination: false);

  @override
  Future<Either<AppErrorModel, PaginationResponse<MyItem>>> fetchItems({
    int? page,
    int? limit,
    String? nextToken,
    String? previousToken,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final response = await apiService.getItems(
        page: page ?? 1,
        limit: limit ?? 10,
        filters: filters,
      );

      return Right(PaginationResponse<MyItem>(
        items: response.items,
        hasReachedEnd: response.hasMore == false,
        hasReachedStart: page <= 1,
        nextPage: response.hasMore ? (page ?? 1) + 1 : null,
      ));
    } catch (error) {
      return Left(AppErrorModel.fromException(error));
    }
  }
}
```

### 2. Usage in Widget

```dart
class MyItemListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MyItemBloc()..add(const LoadInitialPaginationEvent()),
      child: BlocBuilder<MyItemBloc, PaginationState<MyItem>>(
        builder: (context, state) {
          if (state.isLoading) {
            return const CircularProgressIndicator();
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<MyItemBloc>().add(const RefreshPaginationEvent());
            },
            child: ListView.builder(
              itemCount: state.items.length + (state.hasReachedNextEnd ? 0 : 1),
              itemBuilder: (context, index) {
                if (index == state.items.length) {
                  return _buildLoadMoreButton(context, state);
                }
                return _buildItemTile(state.items[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
```

## 🏗️ Architecture Overview

### Core Components

1. **`PaginationBloc<T>`** - Abstract base class providing core pagination functionality
2. **`PaginationState<T>`** - Freezed state class managing pagination data
3. **`PaginationEvent`** - Event classes for pagination actions
4. **`PaginationResponse<T>`** - Response wrapper for API responses

### Available Mixins

1. **`SearchablePaginationBloc<T>`** - Adds search functionality with debouncing
2. **`FilterablePaginationBloc<T>`** - Provides general filtering capabilities
3. **`BothSidePaginationBloc<T>`** - Enhanced bidirectional pagination helpers

## 📊 State Management

### PaginationState Properties

```dart
@freezed
class PaginationState<T> {
  const factory PaginationState({
    // Loading States
    @Default(false) bool isLoading,              // Initial loading
    @Default(false) bool isLoadingNext,          // Loading next page
    @Default(false) bool isLoadingPrevious,      // Loading previous page

    // Data Management
    @Default([]) List<T> items,                  // Current items list
    @Default(1) int currentPage,                 // Current page (offset-based)
    String? nextToken,                           // Next cursor (cursor-based)
    String? previousToken,                       // Previous cursor (cursor-based)

    // Pagination Configuration
    @Default(10) int nextPageSize,               // Items per next page
    @Default(10) int previousPageSize,           // Items per previous page
    int? nextPage,                               // Next page number
    int? totalPages,                             // Total pages available

    // State Tracking
    @Default(false) bool hasLoadedNext,          // Has loaded next page
    @Default(false) bool hasLoadedPrevious,      // Has loaded previous page
    @Default(false) bool hasReachedNextEnd,      // No more next items
    @Default(false) bool hasReachedPreviousEnd,  // No more previous items

    // Filtering & Error
    Map<String, dynamic>? filters,               // Current active filters
    AppErrorModel? error,                        // Current error state
  }) = _PaginationState;
}
```

## 📝 Events Documentation

### Core Events

#### 🔄 LoadInitialPaginationEvent

**Purpose**: Loads the first page of data  
**Parameters**:

- `limit` (optional): Number of items to load

```dart
// Load initial data with default page size
context.read<MyBloc>().add(const LoadInitialPaginationEvent());

// Load initial data with custom page size
context.read<MyBloc>().add(const LoadInitialPaginationEvent(limit: 20));
```

#### ➡️ LoadNextPaginationEvent

**Purpose**: Loads the next page of data  
**Parameters**: None  
**Behavior**: Increments page number (offset) or uses nextToken (cursor)

```dart
context.read<MyBloc>().add(const LoadNextPaginationEvent());
```

#### ⬅️ LoadPreviousPaginationEvent

**Purpose**: Loads the previous page of data  
**Parameters**: None  
**Behavior**: Decrements page number (offset) or uses previousToken (cursor)

```dart
context.read<MyBloc>().add(const LoadPreviousPaginationEvent());
```

#### 🔄 RefreshPaginationEvent

**Purpose**: Refreshes data by resetting to first page  
**Parameters**: None  
**Behavior**: Clears current data, resets pagination, maintains filters

```dart
context.read<MyBloc>().add(const RefreshPaginationEvent());
```

#### 🔍 UpdateFiltersPaginationEvent

**Purpose**: Updates active filters and optionally refreshes data  
**Parameters**:

- `filters`: Map of filter key-value pairs
- `refresh` (optional): Whether to reset pagination (default: false)

```dart
// Update filters without resetting pagination
context.read<MyBloc>().add(UpdateFiltersPaginationEvent({
  'category': 'electronics',
  'status': 'active',
}));

// Update filters and reset to first page
context.read<MyBloc>().add(UpdateFiltersPaginationEvent({
  'category': 'electronics',
}, refresh: true));
```

#### 🔄 RefetchFetchDataEvent

**Purpose**: Refetches current page data  
**Parameters**: None  
**Behavior**: Maintains current page/token and filters

```dart
context.read<MyBloc>().add(const RefetchFetchDataEvent());
```

### Configuration Events

#### 📏 SetNextPageSizeEvent

**Purpose**: Changes the page size for forward pagination  
**Parameters**:

- `pageSize`: New page size for next pagination
- `refresh` (optional): Whether to refresh data (default: false)

```dart
// Change next page size without refresh
context.read<MyBloc>().add(const SetNextPageSizeEvent(20));

// Change next page size and refresh
context.read<MyBloc>().add(const SetNextPageSizeEvent(20, refresh: true));
```

#### 📏 SetPreviousPageSizeEvent

**Purpose**: Changes the page size for backward pagination  
**Parameters**:

- `pageSize`: New page size for previous pagination
- `refresh` (optional): Whether to refresh data (default: false)

```dart
context.read<MyBloc>().add(const SetPreviousPageSizeEvent(15, refresh: true));
```

#### 🎯 JumpToPageEvent

**Purpose**: Jumps directly to a specific page (offset-based only)  
**Parameters**:

- `page`: Target page number

```dart
// Jump to page 5
context.read<MyBloc>().add(const JumpToPageEvent(5));
```

#### 🔄 ResetPaginationEvent

**Purpose**: Resets pagination to initial state  
**Parameters**:

- `keepFilters` (optional): Whether to maintain current filters (default: true)

```dart
// Reset keeping filters
context.read<MyBloc>().add(const ResetPaginationEvent());

// Reset and clear filters
context.read<MyBloc>().add(const ResetPaginationEvent(keepFilters: false));
```

## 🧩 Mixins & Extensions

### SearchablePaginationBloc

Adds search functionality with automatic debouncing.

```dart
class SearchableBloc extends PaginationBloc<MyItem>
    with SearchablePaginationBloc<MyItem> {

  SearchableBloc() : super(useCursorPagination: false) {
    initializeSearch(); // Required initialization
  }

  // ... implement fetchItems
}
```

**Available Properties & Methods**:

```dart
// Properties
TextEditingController searchController;     // Search input controller
String currentSearchQuery;                  // Current search text
bool hasSearchQuery;                        // Whether search is active

// Methods
void initializeSearch();                    // Initialize search functionality
void clearSearch();                         // Clear search query
void setSearchQuery(String query);          // Set search programmatically
```

**Usage Example**:

```dart
// In your widget
TextField(
  controller: context.read<SearchableBloc>().searchController,
  decoration: const InputDecoration(
    hintText: 'Search items...',
    suffixIcon: Icon(Icons.search),
  ),
)

// Clear search programmatically
context.read<SearchableBloc>().clearSearch();

// Set search programmatically
context.read<SearchableBloc>().setSearchQuery('electronics');
```

### FilterablePaginationBloc

Provides advanced filtering capabilities.

```dart
class FilterableBloc extends PaginationBloc<MyItem>
    with FilterablePaginationBloc<MyItem> {

  FilterableBloc() : super(useCursorPagination: false);

  // ... implement fetchItems
}
```

**Available Methods**:

```dart
// Filter Management
void updateFilter(String key, dynamic value);           // Update single filter
void updateFilters(Map<String, dynamic> filters);       // Update multiple filters
void removeFilter(String key);                          // Remove single filter
void removeFilters(List<String> keys);                  // Remove multiple filters
void clearAllFilters();                                 // Clear all filters

// Filter Queries
T? getFilterValue<T>(String key);                       // Get filter value
bool hasFilter(String key);                             // Check if filter exists
Map<String, dynamic> get currentFilters;               // Get all filters
bool get hasAnyFilters;                                 // Check if any filters exist
int get activeFiltersCount;                             // Count active filters
```

**Usage Examples**:

```dart
final bloc = context.read<FilterableBloc>();

// Update single filter
bloc.updateFilter('category', 'electronics');

// Update multiple filters
bloc.updateFilters({
  'category': 'electronics',
  'minPrice': 100,
  'maxPrice': 1000,
});

// Remove filter
bloc.removeFilter('category');

// Check filter value
final category = bloc.getFilterValue<String>('category');

// Clear all filters
bloc.clearAllFilters();
```

### BothSidePaginationBloc

Enhanced bidirectional pagination with additional helper methods.

```dart
class BidirectionalBloc extends PaginationBloc<MyItem>
    with BothSidePaginationBloc<MyItem> {

  BidirectionalBloc() : super(useCursorPagination: false);

  // ... implement fetchItems
}
```

**Available Methods & Properties**:

```dart
// Navigation Methods
void loadNext();                           // Load next page
void loadPrevious();                       // Load previous page
void loadBothSides();                      // Load both directions
void jumpToPage(int page);                 // Jump to specific page
void resetPagination();                    // Reset pagination

// Configuration
void setNextPageSize(int size);            // Set next page size
void setPreviousPageSize(int size);        // Set previous page size

// State Queries
bool get canLoadNext;                      // Can load more next items
bool get canLoadPrevious;                  // Can load more previous items
bool get isLoadingAnyDirection;            // Loading in any direction
bool get hasLoadedNext;                    // Has loaded next page
bool get hasLoadedPrevious;                // Has loaded previous page
bool get hasReachedBothEnds;               // Reached both pagination ends
int get totalItemsCount;                   // Total items loaded
bool get hasItems;                         // Has any items
bool get hasError;                         // Has error state
String? get errorMessage;                  // Current error message
```

## 🔧 Implementation Examples

### Full-Featured Implementation

```dart
class ProductBloc extends PaginationBloc<Product>
    with
        SearchablePaginationBloc<Product>,
        FilterablePaginationBloc<Product>,
        BothSidePaginationBloc<Product> {

  final ProductRepository _repository;

  ProductBloc(this._repository) : super(useCursorPagination: false) {
    initializeSearch(); // Initialize search functionality
  }

  @override
  Future<Either<AppErrorModel, PaginationResponse<Product>>> fetchItems({
    int? page,
    int? limit,
    String? nextToken,
    String? previousToken,
    Map<String, dynamic>? filters,
  }) async {
    try {
      // Extract filters
      final searchQuery = filters?['search'] as String?;
      final category = filters?['category'] as String?;
      final minPrice = filters?['minPrice'] as double?;
      final maxPrice = filters?['maxPrice'] as double?;
      final sortBy = filters?['sortBy'] as String?;

      // Make API call
      final response = await _repository.getProducts(
        page: page ?? 1,
        limit: limit ?? 10,
        search: searchQuery,
        category: category,
        minPrice: minPrice,
        maxPrice: maxPrice,
        sortBy: sortBy,
      );

      return Right(PaginationResponse<Product>(
        items: response.products,
        hasReachedEnd: response.hasMore == false,
        hasReachedStart: (page ?? 1) <= 1,
        nextPage: response.hasMore ? (page ?? 1) + 1 : null,
        totalPages: response.totalPages,
      ));
    } catch (error) {
      return Left(AppErrorModel.fromException(error));
    }
  }
}
```

### Cursor-Based Implementation

```dart
class InfiniteScrollBloc extends PaginationBloc<Post>
    with SearchablePaginationBloc<Post> {

  InfiniteScrollBloc() : super(useCursorPagination: true) {
    initializeSearch();
  }

  @override
  Future<Either<AppErrorModel, PaginationResponse<Post>>> fetchItems({
    int? page,
    int? limit,
    String? nextToken,
    String? previousToken,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final response = await apiService.getPosts(
        limit: limit ?? 20,
        after: nextToken,
        before: previousToken,
        search: filters?['search'] as String?,
      );

      return Right(PaginationResponse<Post>(
        items: response.posts,
        nextToken: response.nextCursor,
        previousToken: response.previousCursor,
        hasReachedEnd: response.nextCursor == null,
        hasReachedStart: response.previousCursor == null,
      ));
    } catch (error) {
      return Left(AppErrorModel.fromException(error));
    }
  }
}
```

## 🖥️ UI Integration

### Basic List with Pagination

```dart
class PaginatedListView<T> extends StatelessWidget {
  final PaginationBloc<T> bloc;
  final Widget Function(T item) itemBuilder;
  final Widget Function(BuildContext context, PaginationState<T> state)? emptyBuilder;
  final Widget Function(BuildContext context, PaginationState<T> state)? errorBuilder;

  const PaginatedListView({
    Key? key,
    required this.bloc,
    required this.itemBuilder,
    this.emptyBuilder,
    this.errorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaginationBloc<T>, PaginationState<T>>(
      bloc: bloc,
      builder: (context, state) {
        if (state.isLoading && state.items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error != null && state.items.isEmpty) {
          return errorBuilder?.call(context, state) ??
                 _buildDefaultError(context, state);
        }

        if (state.items.isEmpty) {
          return emptyBuilder?.call(context, state) ??
                 const Center(child: Text('No items found'));
        }

        return RefreshIndicator(
          onRefresh: () async {
            bloc.add(const RefreshPaginationEvent());
          },
          child: ListView.builder(
            itemCount: state.items.length + (state.hasReachedNextEnd ? 0 : 1),
            itemBuilder: (context, index) {
              if (index == state.items.length) {
                return _buildLoadMoreWidget(context, state);
              }
              return itemBuilder(state.items[index]);
            },
          ),
        );
      },
    );
  }

  Widget _buildLoadMoreWidget(BuildContext context, PaginationState<T> state) {
    if (state.isLoadingNext) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () => bloc.add(const LoadNextPaginationEvent()),
        child: const Text('Load More'),
      ),
    );
  }

  Widget _buildDefaultError(BuildContext context, PaginationState<T> state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Error: ${state.error?.message ?? "Unknown error"}'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => bloc.add(const RefreshPaginationEvent()),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
```

### Search & Filter Integration

```dart
class SearchableProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductBloc()..add(const LoadInitialPaginationEvent()),
      child: Column(
        children: [
          _buildSearchBar(),
          _buildFilterChips(),
          Expanded(child: _buildProductList()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return BlocBuilder<ProductBloc, PaginationState<Product>>(
      builder: (context, state) {
        final bloc = context.read<ProductBloc>();

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: bloc.searchController,
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: bloc.hasSearchQuery
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: bloc.clearSearch,
                    )
                  : null,
              border: const OutlineInputBorder(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterChips() {
    return BlocBuilder<ProductBloc, PaginationState<Product>>(
      builder: (context, state) {
        final bloc = context.read<ProductBloc>();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              FilterChip(
                label: const Text('Electronics'),
                selected: bloc.getFilterValue('category') == 'electronics',
                onSelected: (selected) {
                  if (selected) {
                    bloc.updateFilter('category', 'electronics');
                  } else {
                    bloc.removeFilter('category');
                  }
                },
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('Under \$100'),
                selected: bloc.hasFilter('maxPrice'),
                onSelected: (selected) {
                  if (selected) {
                    bloc.updateFilter('maxPrice', 100.0);
                  } else {
                    bloc.removeFilter('maxPrice');
                  }
                },
              ),
              // Add more filter chips as needed
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductList() {
    return BlocBuilder<ProductBloc, PaginationState<Product>>(
      builder: (context, state) {
        return PaginatedListView<Product>(
          bloc: context.read<ProductBloc>(),
          itemBuilder: (product) => ProductListTile(product: product),
          emptyBuilder: (context, state) => const Center(
            child: Text('No products found'),
          ),
        );
      },
    );
  }
}
```

## 💡 Best Practices

### 1. Error Handling

```dart
@override
Future<Either<AppErrorModel, PaginationResponse<T>>> fetchItems({...}) async {
  try {
    // Your API call
    final response = await apiCall();
    return Right(response);
  } on NetworkException catch (e) {
    return Left(AppErrorModel.network(e.message));
  } on ServerException catch (e) {
    return Left(AppErrorModel.server(e.message));
  } catch (e) {
    return Left(AppErrorModel.unknown(e.toString()));
  }
}
```

### 2. State Preservation

```dart
// Use BlocProvider.value when navigating to preserve state
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => BlocProvider.value(
      value: context.read<MyBloc>(),
      child: DetailScreen(),
    ),
  ),
);
```

### 3. Memory Management

```dart
class MyBloc extends PaginationBloc<MyItem>
    with SearchablePaginationBloc<MyItem> {

  @override
  Future<void> close() {
    // Clean up resources
    searchController.dispose();
    return super.close();
  }
}
```

### 4. Testing

```dart
void main() {
  group('PaginationBloc', () {
    late MyBloc bloc;

    setUp(() {
      bloc = MyBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('should emit loading state when loading initial data', () {
      bloc.add(const LoadInitialPaginationEvent());

      expect(
        bloc.stream,
        emitsInOrder([
          isA<PaginationState>().having((s) => s.isLoading, 'isLoading', true),
          isA<PaginationState>().having((s) => s.items, 'items', isNotEmpty),
        ]),
      );
    });
  });
}
```

## 🔍 Troubleshooting

### Common Issues

1. **Search not working**: Make sure to call `initializeSearch()` in constructor
2. **Filters not applied**: Check that your `fetchItems` method handles the filters parameter
3. **Infinite loading**: Ensure `hasReachedEnd` is properly set in `PaginationResponse`
4. **Memory leaks**: Don't forget to dispose controllers in `close()` method

### Debug Information

Enable debug logging to track pagination events:

```dart
class MyBloc extends PaginationBloc<MyItem> {
  @override
  void add(PaginationEvent event) {
    debugPrint('PaginationEvent: $event');
    super.add(event);
  }

  @override
  void emit(PaginationState<MyItem> state) {
    debugPrint('PaginationState: ${state.items.length} items, page: ${state.currentPage}');
    super.emit(state);
  }
}
```

---

This pagination system provides a robust foundation for handling complex data loading scenarios in Flutter applications. For more examples and advanced usage patterns, check the `example_usage.dart` file in this directory.
