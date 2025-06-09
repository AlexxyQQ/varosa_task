import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../config/constants/fonts/all_text_styles.dart';
import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../common/presentation/views/widgets/app_text.widget.dart';
import '../../bloc/pagination/mixins/filterable_pagination.bloc.dart';
import '../../bloc/pagination/pagination.bloc.dart';
import 'pagination_list_view.widget.dart';
import 'pagination_types.dart';

/// A pagination ListView widget with filtering functionality
class FilterablePaginationListView<T> extends StatelessWidget {
  /// The filterable pagination bloc to use
  final PaginationBloc<T> bloc;

  /// Builder function for each item
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// Available filter items
  final List<FilterItem> filterItems;

  /// Widget to show when the list is empty
  final Widget? emptyWidget;

  /// Widget to show while loading
  final Widget? loadingWidget;

  /// Widget to show when there's an error
  final Widget Function(BuildContext context, String error)? errorBuilder;

  /// Scroll controller for the list
  final ScrollController? scrollController;

  /// Whether to show a load more button instead of automatic loading
  final bool showLoadMoreButton;

  /// Custom separator between items
  final Widget? separator;

  /// Padding for the list
  final EdgeInsets? padding;

  /// Whether to enable pull to refresh
  final bool enablePullToRefresh;

  /// Custom refresh indicator color
  final Color? refreshIndicatorColor;

  /// Whether to show filter chips
  final bool showFilters;

  /// Whether filters can have multiple selections
  final bool allowMultipleFilters;

  /// Custom filter chip styling
  final ChipThemeData? filterChipTheme;

  /// Filter section title
  final String filterSectionTitle;

  /// Whether to show clear all filters button
  final bool showClearFiltersButton;

  const FilterablePaginationListView({
    super.key,
    required this.bloc,
    required this.itemBuilder,
    this.filterItems = const [],
    this.emptyWidget,
    this.loadingWidget,
    this.errorBuilder,
    this.scrollController,
    this.showLoadMoreButton = false,
    this.separator,
    this.padding,
    this.enablePullToRefresh = true,
    this.refreshIndicatorColor,
    this.showFilters = true,
    this.allowMultipleFilters = true,
    this.filterChipTheme,
    this.filterSectionTitle = 'Filters',
    this.showClearFiltersButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showFilters && filterItems.isNotEmpty)
          _buildFiltersSection(context),
        Expanded(
          child: PaginationListView<T>(
            bloc: bloc,
            itemBuilder: itemBuilder,
            emptyWidget: emptyWidget,
            loadingWidget: loadingWidget,
            errorBuilder: errorBuilder,
            scrollController: scrollController,
            showLoadMoreButton: showLoadMoreButton,
            separator: separator,
            padding: padding,
            enablePullToRefresh: enablePullToRefresh,
            refreshIndicatorColor: refreshIndicatorColor,
          ),
        ),
      ],
    );
  }

  Widget _buildFiltersSection(BuildContext context) {
    return BlocBuilder<PaginationBloc<T>, PaginationState<T>>(
      bloc: bloc,
      builder: (context, state) {
        final activeFilters = state.filters ?? {};
        final hasActiveFilters = activeFilters.isNotEmpty;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
          decoration: const BoxDecoration(
            color: PrimitiveColors.white,
            border: Border(bottom: BorderSide(color: PrimitiveColors.stroke)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    filterSectionTitle,
                    style: AllTextStyle.f16W6.copyWith(
                      color: PrimitiveColors.black,
                    ),
                  ),
                  if (showClearFiltersButton && hasActiveFilters)
                    TextButton(
                      onPressed: _clearAllFilters,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: AppText(
                        'Clear All',
                        style: AllTextStyle.f12W5.copyWith(
                          color: PrimitiveColors.red,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 4.h,
                children: filterItems.map((filter) {
                  final isActive = _isFilterActive(filter, activeFilters);
                  return _FilterChip(
                    filter: filter,
                    isActive: isActive,
                    onTap: () => _toggleFilter(filter),
                    theme: filterChipTheme,
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  bool _isFilterActive(FilterItem filter, Map<String, dynamic> activeFilters) {
    final value = activeFilters[filter.key];
    if (value == null) return false;

    if (allowMultipleFilters && value is List) {
      return value.contains(filter.value);
    }

    return value == filter.value;
  }

  void _toggleFilter(FilterItem filter) {
    if (bloc is! FilterablePaginationBloc<T>) return;

    final filterableBloc = bloc as FilterablePaginationBloc<T>;
    final currentFilters = filterableBloc.currentFilters;
    final currentValue = currentFilters[filter.key];

    if (allowMultipleFilters) {
      List<dynamic> newValue = [];
      if (currentValue is List) {
        newValue = List.from(currentValue);
      }

      if (newValue.contains(filter.value)) {
        newValue.remove(filter.value);
      } else {
        newValue.add(filter.value);
      }

      if (newValue.isEmpty) {
        filterableBloc.removeFilter(filter.key);
      } else {
        filterableBloc.updateFilter(filter.key, newValue);
      }
    } else {
      if (currentValue == filter.value) {
        filterableBloc.removeFilter(filter.key);
      } else {
        filterableBloc.updateFilter(filter.key, filter.value);
      }
    }
  }

  void _clearAllFilters() {
    if (bloc is FilterablePaginationBloc<T>) {
      (bloc as FilterablePaginationBloc<T>).clearAllFilters();
    }
  }
}

class _FilterChip extends StatelessWidget {
  final FilterItem filter;
  final bool isActive;
  final VoidCallback onTap;
  final ChipThemeData? theme;

  const _FilterChip({
    required this.filter,
    required this.isActive,
    required this.onTap,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isActive ? PrimitiveColors.primary : PrimitiveColors.white,
          border: Border.all(
            color: isActive ? PrimitiveColors.primary : PrimitiveColors.stroke,
          ),
          borderRadius: AppSize.allRadius20,
        ),
        child: AppText(
          filter.label,
          style: AllTextStyle.f12W5.copyWith(
            color: isActive ? PrimitiveColors.onPrimary : PrimitiveColors.black,
          ),
        ),
      ),
    );
  }
}
