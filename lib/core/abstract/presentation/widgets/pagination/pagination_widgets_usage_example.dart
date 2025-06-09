// Example usage of the pagination widgets
// This file shows how to implement and use the various pagination widgets

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../config/constants/fonts/all_text_styles.dart';
import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../common/presentation/views/widgets/app_text.widget.dart';
import '../../bloc/pagination/pagination.bloc.dart';
import 'both_side_pagination_list_view.widget.dart';
import 'filterable_pagination_list_view.widget.dart';
import 'full_featured_pagination_list_view.widget.dart';
import 'pagination_list_view.widget.dart';
import 'pagination_types.dart';
import 'searchable_pagination_list_view.widget.dart';

// Example data model
class ExampleItem {
  final String id;
  final String name;
  final String description;
  final String category;
  final bool isActive;

  ExampleItem({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    this.isActive = true,
  });
}

// Example item widget
class ExampleItemWidget extends StatelessWidget {
  final ExampleItem item;
  final int index;

  const ExampleItemWidget({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSize.allPadding16,
      decoration: BoxDecoration(
        color: PrimitiveColors.white,
        borderRadius: AppSize.allRadius12,
        border: Border.all(color: PrimitiveColors.stroke),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: item.isActive
                      ? PrimitiveColors.green
                      : PrimitiveColors.red,
                  borderRadius: AppSize.allRadius20,
                ),
                child: Center(
                  child: AppText(
                    '${index + 1}',
                    style: AllTextStyle.f14W6.copyWith(
                      color: PrimitiveColors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      item.name,
                      style: AllTextStyle.f16W6.copyWith(
                        color: PrimitiveColors.black,
                      ),
                    ),
                    AppText(
                      item.category,
                      style: AllTextStyle.f12W4.copyWith(
                        color: PrimitiveColors.hintText,
                      ),
                    ),
                  ],
                ),
              ),
              if (item.isActive)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: PrimitiveColors.green.withOpacity(0.1),
                    borderRadius: AppSize.allRadius8,
                  ),
                  child: AppText(
                    'Active',
                    style: AllTextStyle.f10W5.copyWith(
                      color: PrimitiveColors.green,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          AppText(
            item.description,
            style: AllTextStyle.f14W4.copyWith(color: PrimitiveColors.black),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// Example 1: Basic Pagination ListView
class BasicPaginationExample extends StatelessWidget {
  final PaginationBloc<ExampleItem> bloc;

  const BasicPaginationExample({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppText('Basic Pagination')),
      body: PaginationListView<ExampleItem>(
        bloc: bloc,
        itemBuilder: (context, item, index) =>
            ExampleItemWidget(item: item, index: index),
        emptyWidget: _buildEmptyWidget(),
        showLoadMoreButton:
            true, // Use load more button instead of auto-loading
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.list_alt, size: 64.w, color: PrimitiveColors.hintText),
          SizedBox(height: 16.h),
          AppText(
            'No items to display',
            style: AllTextStyle.f16W5.copyWith(color: PrimitiveColors.hintText),
          ),
        ],
      ),
    );
  }
}

// Example 2: Searchable Pagination ListView
class SearchablePaginationExample extends StatelessWidget {
  final PaginationBloc<ExampleItem> searchableBloc;

  const SearchablePaginationExample({super.key, required this.searchableBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppText('Searchable Pagination')),
      body: SearchablePaginationListView<ExampleItem>(
        bloc: searchableBloc,
        itemBuilder: (context, item, index) =>
            ExampleItemWidget(item: item, index: index),
        searchHint: 'Search items...',
        noSearchResultsWidget: _buildNoSearchResultsWidget(),
      ),
    );
  }

  Widget _buildNoSearchResultsWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64.w, color: PrimitiveColors.hintText),
          SizedBox(height: 16.h),
          AppText(
            'No matching results',
            style: AllTextStyle.f16W5.copyWith(color: PrimitiveColors.hintText),
          ),
          AppText(
            'Try adjusting your search terms',
            style: AllTextStyle.f14W4.copyWith(color: PrimitiveColors.hintText),
          ),
        ],
      ),
    );
  }
}

// Example 3: Filterable Pagination ListView
class FilterablePaginationExample extends StatelessWidget {
  final PaginationBloc<ExampleItem> filterableBloc;

  const FilterablePaginationExample({super.key, required this.filterableBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppText('Filterable Pagination')),
      body: FilterablePaginationListView<ExampleItem>(
        bloc: filterableBloc,
        itemBuilder: (context, item, index) =>
            ExampleItemWidget(item: item, index: index),
        filterItems: [
          const FilterItem(
            key: 'category',
            label: 'Electronics',
            value: 'electronics',
          ),
          const FilterItem(
            key: 'category',
            label: 'Clothing',
            value: 'clothing',
          ),
          const FilterItem(key: 'category', label: 'Books', value: 'books'),
          const FilterItem(key: 'status', label: 'Active Only', value: true),
          const FilterItem(key: 'status', label: 'Inactive Only', value: false),
        ],
        filterSectionTitle: 'Filter by Category & Status',
      ),
    );
  }
}

// Example 4: Both-Side Pagination ListView
class BothSidePaginationExample extends StatelessWidget {
  final PaginationBloc<ExampleItem> bothSideBloc;

  const BothSidePaginationExample({super.key, required this.bothSideBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppText('Both-Side Pagination')),
      body: BothSidePaginationListView<ExampleItem>(
        bloc: bothSideBloc,
        itemBuilder: (context, item, index) =>
            ExampleItemWidget(item: item, index: index),
        showPaginationControls: true,
      ),
    );
  }
}

// Example 5: Full-Featured Pagination ListView
class FullFeaturedPaginationExample extends StatelessWidget {
  final PaginationBloc<ExampleItem> fullFeaturedBloc;

  const FullFeaturedPaginationExample({
    super.key,
    required this.fullFeaturedBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText('Full-Featured Pagination'),
        elevation: 0,
      ),
      body: FullFeaturedPaginationListView<ExampleItem>(
        bloc: fullFeaturedBloc,
        itemBuilder: (context, item, index) =>
            ExampleItemWidget(item: item, index: index),
        searchHint: 'Search by name or description...',
        filterItems: [
          const FilterItem(
            key: 'category',
            label: 'Electronics',
            value: 'electronics',
          ),
          const FilterItem(
            key: 'category',
            label: 'Clothing',
            value: 'clothing',
          ),
          const FilterItem(key: 'category', label: 'Books', value: 'books'),
          const FilterItem(key: 'category', label: 'Sports', value: 'sports'),
          const FilterItem(key: 'status', label: 'Active', value: true),
          const FilterItem(key: 'status', label: 'Inactive', value: false),
        ],
        stickyHeader: true, // Make search and filters sticky
        // Custom widgets
        emptyWidget: _buildEmptyWidget(),
        noSearchResultsWidget: _buildNoSearchResultsWidget(),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Padding(
        padding: AppSize.allPadding24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 80.w,
              color: PrimitiveColors.hintText,
            ),
            SizedBox(height: 24.h),
            AppText(
              'No Items Available',
              style: AllTextStyle.f20W6.copyWith(color: PrimitiveColors.black),
            ),
            SizedBox(height: 8.h),
            AppText(
              'There are currently no items to display.\nCheck back later or try refreshing.',
              style: AllTextStyle.f14W4.copyWith(
                color: PrimitiveColors.hintText,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoSearchResultsWidget() {
    return Center(
      child: Padding(
        padding: AppSize.allPadding24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 80.w,
              color: PrimitiveColors.hintText,
            ),
            SizedBox(height: 24.h),
            AppText(
              'No Results Found',
              style: AllTextStyle.f20W6.copyWith(color: PrimitiveColors.black),
            ),
            SizedBox(height: 8.h),
            AppText(
              'We couldn\'t find any items matching your search criteria.\nTry different keywords or clear filters.',
              style: AllTextStyle.f14W4.copyWith(
                color: PrimitiveColors.hintText,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Example 6: Custom Error Handling
class CustomErrorPaginationExample extends StatelessWidget {
  final PaginationBloc<ExampleItem> bloc;

  const CustomErrorPaginationExample({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppText('Custom Error Handling')),
      body: PaginationListView<ExampleItem>(
        bloc: bloc,
        itemBuilder: (context, item, index) =>
            ExampleItemWidget(item: item, index: index),
        errorBuilder: (context, error) => _buildCustomErrorWidget(error),
      ),
    );
  }

  Widget _buildCustomErrorWidget(String error) {
    return Center(
      child: Padding(
        padding: AppSize.allPadding24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: AppSize.allPadding24,
              decoration: BoxDecoration(
                color: PrimitiveColors.red.withOpacity(0.1),
                borderRadius: AppSize.allRadius16,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 64.w,
                color: PrimitiveColors.red,
              ),
            ),
            SizedBox(height: 24.h),
            AppText(
              'Oops! Something went wrong',
              style: AllTextStyle.f20W6.copyWith(color: PrimitiveColors.black),
            ),
            SizedBox(height: 8.h),
            AppText(
              error,
              style: AllTextStyle.f14W4.copyWith(
                color: PrimitiveColors.hintText,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () => bloc.add(const RefreshPaginationEvent()),
                  icon: const Icon(Icons.refresh),
                  label: const AppText('Retry'),
                  style: TextButton.styleFrom(
                    foregroundColor: PrimitiveColors.primary,
                  ),
                ),
                SizedBox(width: 16.w),
                TextButton.icon(
                  onPressed: () {
                    // Handle contact support or other action
                  },
                  icon: const Icon(Icons.support_agent),
                  label: const AppText('Contact Support'),
                  style: TextButton.styleFrom(
                    foregroundColor: PrimitiveColors.hintText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/*
Usage in your screens:

1. For basic pagination:
```dart
PaginationListView<ExampleItem>(
  bloc: myBasicPaginationBloc,
  itemBuilder: (context, item, index) => ExampleItemWidget(
    item: item,
    index: index,
  ),
)
```

2. For searchable pagination:
```dart
SearchablePaginationListView<ExampleItem>(
  bloc: mySearchablePaginationBloc, // Must implement SearchablePaginationBloc
  itemBuilder: (context, item, index) => ExampleItemWidget(
    item: item,
    index: index,
  ),
  searchHint: 'Search items...',
)
```

3. For filterable pagination:
```dart
FilterablePaginationListView<ExampleItem>(
  bloc: myFilterablePaginationBloc, // Must implement FilterablePaginationBloc
  itemBuilder: (context, item, index) => ExampleItemWidget(
    item: item,
    index: index,
  ),
  filterItems: [
    FilterItem(key: 'category', label: 'Electronics', value: 'electronics'),
    FilterItem(key: 'status', label: 'Active', value: true),
  ],
)
```

4. For both-side pagination:
```dart
BothSidePaginationListView<ExampleItem>(
  bloc: myBothSidePaginationBloc, // Must implement BothSidePaginationBloc
  itemBuilder: (context, item, index) => ExampleItemWidget(
    item: item,
    index: index,
  ),
  showPaginationControls: true,
)
```

5. For full-featured pagination:
```dart
FullFeaturedPaginationListView<ExampleItem>(
  bloc: myFullFeaturedBloc, // Must implement all mixins
  itemBuilder: (context, item, index) => ExampleItemWidget(
    item: item,
    index: index,
  ),
  showSearchField: true,
  showFilters: true,
  filterItems: [/* your filters */],
  showPaginationControls: true,
  stickyHeader: true,
)
```

Key Features:
- ✅ Automatic loading as you scroll
- ✅ Pull to refresh support
- ✅ Load more button option
- ✅ Search functionality with debouncing
- ✅ Multi-select filtering
- ✅ Both-direction pagination
- ✅ Custom error and empty states
- ✅ Loading indicators
- ✅ Pagination controls with page info
- ✅ Sticky headers
- ✅ Customizable styling
- ✅ Type-safe generic implementation
*/
