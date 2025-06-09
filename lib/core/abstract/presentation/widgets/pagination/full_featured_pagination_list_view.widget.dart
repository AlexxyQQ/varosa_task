import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../config/constants/fonts/all_text_styles.dart';
import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../common/presentation/views/widgets/app_button.widget.dart';
import '../../../../common/presentation/views/widgets/app_text.widget.dart';
import '../../bloc/pagination/mixins/both_side_pagination.bloc.dart';
import '../../bloc/pagination/mixins/filterable_pagination.bloc.dart';
import '../../bloc/pagination/mixins/searchable_pagination.bloc.dart';
import '../../bloc/pagination/pagination.bloc.dart';
import 'pagination_list_view.widget.dart';
import 'pagination_types.dart';

/// A comprehensive pagination ListView widget with search, filters, and both-side navigation
class FullFeaturedPaginationListView<T> extends StatelessWidget {
  /// The full-featured pagination bloc to use
  final PaginationBloc<T> bloc;

  /// Builder function for each item
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// Available filter items
  final List<FilterItem> filterItems;

  /// Widget to show when the list is empty
  final Widget? emptyWidget;

  /// Widget to show when no search results found
  final Widget? noSearchResultsWidget;

  /// Widget to show while loading
  final Widget? loadingWidget;

  /// Widget to show when there's an error
  final Widget Function(BuildContext context, String error)? errorBuilder;

  /// Scroll controller for the list
  final ScrollController? scrollController;

  /// Whether to show load more buttons instead of automatic loading
  final bool showLoadMoreButtons;

  /// Custom separator between items
  final Widget? separator;

  /// Padding for the list
  final EdgeInsets? padding;

  /// Whether to enable pull to refresh
  final bool enablePullToRefresh;

  /// Custom refresh indicator color
  final Color? refreshIndicatorColor;

  /// Search field placeholder text
  final String searchHint;

  /// Whether to show the search field
  final bool showSearchField;

  /// Whether to show filter chips
  final bool showFilters;

  /// Whether filters can have multiple selections
  final bool allowMultipleFilters;

  /// Filter section title
  final String filterSectionTitle;

  /// Whether to show clear all filters button
  final bool showClearFiltersButton;

  /// Whether to show pagination controls
  final bool showPaginationControls;

  /// Whether to show page info
  final bool showPageInfo;

  /// Custom pagination controls position
  final PaginationControlsPosition controlsPosition;

  /// Whether the header (search + filters) should be sticky
  final bool stickyHeader;

  const FullFeaturedPaginationListView({
    super.key,
    required this.bloc,
    required this.itemBuilder,
    this.filterItems = const [],
    this.emptyWidget,
    this.noSearchResultsWidget,
    this.loadingWidget,
    this.errorBuilder,
    this.scrollController,
    this.showLoadMoreButtons = false,
    this.separator,
    this.padding,
    this.enablePullToRefresh = true,
    this.refreshIndicatorColor,
    this.searchHint = 'Search...',
    this.showSearchField = true,
    this.showFilters = true,
    this.allowMultipleFilters = true,
    this.filterSectionTitle = 'Filters',
    this.showClearFiltersButton = true,
    this.showPaginationControls = true,
    this.showPageInfo = true,
    this.controlsPosition = PaginationControlsPosition.bottom,
    this.stickyHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    if (stickyHeader) {
      return _buildWithStickyHeader(context);
    } else {
      return _buildRegular(context);
    }
  }

  Widget _buildWithStickyHeader(BuildContext context) {
    return Column(
      children: [
        if (showPaginationControls &&
            controlsPosition == PaginationControlsPosition.top)
          _buildPaginationControls(context),
        if (showSearchField || (showFilters && filterItems.isNotEmpty))
          _buildStickyHeader(context),
        Expanded(
          child: BlocBuilder<PaginationBloc<T>, PaginationState<T>>(
            bloc: bloc,
            builder: (context, state) {
              return _buildListContent(context, state);
            },
          ),
        ),
        if (showPaginationControls &&
            controlsPosition == PaginationControlsPosition.bottom)
          _buildPaginationControls(context),
      ],
    );
  }

  Widget _buildRegular(BuildContext context) {
    return Column(
      children: [
        if (showPaginationControls &&
            controlsPosition == PaginationControlsPosition.top)
          _buildPaginationControls(context),
        if (showSearchField) _buildSearchField(context),
        if (showFilters && filterItems.isNotEmpty)
          _buildFiltersSection(context),
        Expanded(
          child: BlocBuilder<PaginationBloc<T>, PaginationState<T>>(
            bloc: bloc,
            builder: (context, state) {
              return _buildListContent(context, state);
            },
          ),
        ),
        if (showPaginationControls &&
            controlsPosition == PaginationControlsPosition.bottom)
          _buildPaginationControls(context),
      ],
    );
  }

  Widget _buildStickyHeader(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: PrimitiveColors.white,
        boxShadow: [
          BoxShadow(
            color: PrimitiveColors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          if (showSearchField) _buildSearchField(context),
          if (showFilters && filterItems.isNotEmpty)
            _buildFiltersSection(context),
        ],
      ),
    );
  }

  Widget _buildListContent(BuildContext context, PaginationState<T> state) {
    final isSearchActive = _isSearchActive();
    final shouldShowNoResults =
        state.items.isEmpty &&
        !state.isLoading &&
        state.error == null &&
        isSearchActive;

    if (shouldShowNoResults) {
      return noSearchResultsWidget ??
          _DefaultNoSearchResultsWidget(
            searchQuery: _getSearchQuery(),
            onClearSearch: _clearSearch,
          );
    }

    // Use both-side pagination if available
    if (bloc is BothSidePaginationBloc<T>) {
      return _buildBothSideList(context);
    }

    return PaginationListView<T>(
      bloc: bloc,
      itemBuilder: itemBuilder,
      emptyWidget: emptyWidget,
      loadingWidget: loadingWidget,
      errorBuilder: errorBuilder,
      scrollController: scrollController,
      showLoadMoreButton: showLoadMoreButtons,
      separator: separator,
      padding: padding,
      enablePullToRefresh: enablePullToRefresh,
      refreshIndicatorColor: refreshIndicatorColor,
    );
  }

  Widget _buildBothSideList(BuildContext context) {
    return BlocBuilder<PaginationBloc<T>, PaginationState<T>>(
      bloc: bloc,
      builder: (context, state) {
        if (state.isLoading && state.items.isEmpty) {
          return loadingWidget ?? const _DefaultLoadingWidget();
        }

        if (state.error != null && state.items.isEmpty) {
          return errorBuilder?.call(context, state.error!.message) ??
              _DefaultErrorWidget(
                error: state.error!.message,
                onRetry: () => bloc.add(const RefreshPaginationEvent()),
              );
        }

        if (state.items.isEmpty) {
          return emptyWidget ?? const _DefaultEmptyWidget();
        }

        final bothSideBloc = bloc as BothSidePaginationBloc<T>;
        int itemCount = state.items.length;

        if (showLoadMoreButtons) {
          if (bothSideBloc.canLoadPrevious) itemCount++;
          if (bothSideBloc.canLoadNext) itemCount++;
        }

        Widget listView = ListView.separated(
          controller: scrollController,
          padding: padding ?? AppSize.allPadding16,
          itemCount: itemCount,
          separatorBuilder: (context, index) =>
              separator ?? SizedBox(height: 8.h),
          itemBuilder: (context, index) {
            if (showLoadMoreButtons) {
              if (index == 0 && bothSideBloc.canLoadPrevious) {
                return _LoadPreviousButton(bloc: bloc, state: state);
              }

              final adjustedIndex = bothSideBloc.canLoadPrevious
                  ? index - 1
                  : index;

              if (adjustedIndex >= state.items.length) {
                return _LoadNextButton(bloc: bloc, state: state);
              }

              return itemBuilder(
                context,
                state.items[adjustedIndex],
                adjustedIndex,
              );
            } else {
              if (index <= 2 && !state.isLoadingPrevious) {
                _triggerLoadPrevious();
              }

              if (index >= state.items.length - 3 && !state.isLoadingNext) {
                _triggerLoadNext();
              }

              return itemBuilder(context, state.items[index], index);
            }
          },
        );

        if (enablePullToRefresh) {
          listView = RefreshIndicator(
            color: refreshIndicatorColor ?? PrimitiveColors.primary,
            onRefresh: () async {
              bloc.add(const RefreshPaginationEvent());
              await bloc.stream
                  .firstWhere((state) => !state.isLoading)
                  .timeout(const Duration(seconds: 10));
            },
            child: listView,
          );
        }

        return Stack(
          children: [
            listView,
            if (state.isLoadingPrevious && !showLoadMoreButtons)
              const Positioned(
                top: 16,
                left: 0,
                right: 0,
                child: _LoadingIndicator(text: 'Loading previous...'),
              ),
            if (state.isLoadingNext && !showLoadMoreButtons)
              const Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: _LoadingIndicator(text: 'Loading next...'),
              ),
          ],
        );
      },
    );
  }

  Widget _buildSearchField(BuildContext context) {
    if (bloc is! SearchablePaginationBloc<T>) {
      return const SizedBox.shrink();
    }

    final searchableBloc = bloc as SearchablePaginationBloc<T>;

    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
      child: TextField(
        controller: searchableBloc.searchController,
        decoration: InputDecoration(
          hintText: searchHint,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: searchableBloc.hasSearchQuery
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: searchableBloc.clearSearch,
                )
              : null,
          border: const OutlineInputBorder(
            borderRadius: AppSize.allRadius12,
            borderSide: BorderSide(color: PrimitiveColors.stroke),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: AppSize.allRadius12,
            borderSide: BorderSide(color: PrimitiveColors.stroke),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: AppSize.allRadius12,
            borderSide: BorderSide(color: PrimitiveColors.primary),
          ),
          contentPadding: AppSize.allPadding16,
          filled: true,
          fillColor: PrimitiveColors.white,
        ),
      ),
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
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
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
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaginationControls(BuildContext context) {
    if (bloc is! BothSidePaginationBloc<T>) {
      return const SizedBox.shrink();
    }

    final bothSideBloc = bloc as BothSidePaginationBloc<T>;

    return BlocBuilder<PaginationBloc<T>, PaginationState<T>>(
      bloc: bloc,
      builder: (context, state) {
        return Container(
          padding: AppSize.allPadding16,
          decoration: BoxDecoration(
            color: PrimitiveColors.white,
            border: Border(
              top: controlsPosition == PaginationControlsPosition.bottom
                  ? const BorderSide(color: PrimitiveColors.stroke)
                  : BorderSide.none,
              bottom: controlsPosition == PaginationControlsPosition.top
                  ? const BorderSide(color: PrimitiveColors.stroke)
                  : BorderSide.none,
            ),
          ),
          child: Column(
            children: [
              if (showPageInfo) _buildPageInfo(bothSideBloc),
              if (showPageInfo) SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: AppButton.stroke(
                      onPressed: bothSideBloc.canLoadPrevious
                          ? () => bothSideBloc.loadPrevious()
                          : null,
                      label: 'Previous',
                      isLoading: state.isLoadingPrevious,
                      isDisabled: !bothSideBloc.canLoadPrevious,
                      height: 40.h,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: AppButton.primary(
                      onPressed: () => bloc.add(const RefreshPaginationEvent()),
                      label: 'Refresh',
                      isLoading: state.isLoading,
                      height: 40.h,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: AppButton.stroke(
                      onPressed: bothSideBloc.canLoadNext
                          ? () => bothSideBloc.loadNext()
                          : null,
                      label: 'Next',
                      isLoading: state.isLoadingNext,
                      isDisabled: !bothSideBloc.canLoadNext,
                      height: 40.h,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPageInfo(BothSidePaginationBloc<T> bothSideBloc) {
    return AppText(
      'Page ${bothSideBloc.currentPage} • ${bothSideBloc.totalItemsCount} items loaded',
      style: AllTextStyle.f12W4.copyWith(color: PrimitiveColors.hintText),
    );
  }

  // Helper methods
  bool _isSearchActive() {
    if (bloc is! SearchablePaginationBloc<T>) return false;
    return (bloc as SearchablePaginationBloc<T>).hasSearchQuery;
  }

  String _getSearchQuery() {
    if (bloc is! SearchablePaginationBloc<T>) return '';
    return (bloc as SearchablePaginationBloc<T>).currentSearchQuery;
  }

  void _clearSearch() {
    if (bloc is SearchablePaginationBloc<T>) {
      (bloc as SearchablePaginationBloc<T>).clearSearch();
    }
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

  void _triggerLoadPrevious() {
    if (bloc is BothSidePaginationBloc<T>) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        (bloc as BothSidePaginationBloc<T>).loadPrevious();
      });
    }
  }

  void _triggerLoadNext() {
    if (bloc is BothSidePaginationBloc<T>) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        (bloc as BothSidePaginationBloc<T>).loadNext();
      });
    }
  }
}

// Reusable components
class _FilterChip extends StatelessWidget {
  final FilterItem filter;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChip({
    required this.filter,
    required this.isActive,
    required this.onTap,
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

class _LoadPreviousButton<T> extends StatelessWidget {
  final PaginationBloc<T> bloc;
  final PaginationState<T> state;

  const _LoadPreviousButton({required this.bloc, required this.state});

  @override
  Widget build(BuildContext context) {
    if (bloc is! BothSidePaginationBloc<T>) return const SizedBox.shrink();
    final bothSideBloc = bloc as BothSidePaginationBloc<T>;

    if (!bothSideBloc.canLoadPrevious) {
      return Container(
        padding: AppSize.allPadding16,
        alignment: Alignment.center,
        child: AppText(
          'Start of list',
          style: AllTextStyle.f14W5.copyWith(color: PrimitiveColors.hintText),
        ),
      );
    }

    return Container(
      padding: AppSize.allPadding16,
      child: AppButton.stroke(
        onPressed: () => bothSideBloc.loadPrevious(),
        label: 'Load Previous',
        isLoading: state.isLoadingPrevious,
        height: 40.h,
      ),
    );
  }
}

class _LoadNextButton<T> extends StatelessWidget {
  final PaginationBloc<T> bloc;
  final PaginationState<T> state;

  const _LoadNextButton({required this.bloc, required this.state});

  @override
  Widget build(BuildContext context) {
    if (bloc is! BothSidePaginationBloc<T>) return const SizedBox.shrink();
    final bothSideBloc = bloc as BothSidePaginationBloc<T>;

    if (!bothSideBloc.canLoadNext) {
      return Container(
        padding: AppSize.allPadding16,
        alignment: Alignment.center,
        child: AppText(
          'End of list',
          style: AllTextStyle.f14W5.copyWith(color: PrimitiveColors.hintText),
        ),
      );
    }

    return Container(
      padding: AppSize.allPadding16,
      child: AppButton.stroke(
        onPressed: () => bothSideBloc.loadNext(),
        label: 'Load Next',
        isLoading: state.isLoadingNext,
        height: 40.h,
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  final String text;

  const _LoadingIndicator({this.text = 'Loading...'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: AppSize.allPadding12,
        decoration: BoxDecoration(
          color: PrimitiveColors.white,
          borderRadius: AppSize.allRadius8,
          boxShadow: [
            BoxShadow(
              color: PrimitiveColors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16.w,
              height: 16.h,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(PrimitiveColors.primary),
              ),
            ),
            SizedBox(width: 8.w),
            AppText(
              text,
              style: AllTextStyle.f12W5.copyWith(color: PrimitiveColors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class _DefaultNoSearchResultsWidget extends StatelessWidget {
  final String searchQuery;
  final VoidCallback? onClearSearch;

  const _DefaultNoSearchResultsWidget({
    required this.searchQuery,
    this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSize.allPadding16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 48.w, color: PrimitiveColors.hintText),
            SizedBox(height: 16.h),
            AppText(
              'No results found',
              style: AllTextStyle.f16W6.copyWith(color: PrimitiveColors.black),
            ),
            SizedBox(height: 8.h),
            AppText(
              'No items match "$searchQuery"',
              style: AllTextStyle.f14W4.copyWith(
                color: PrimitiveColors.hintText,
              ),
              textAlign: TextAlign.center,
            ),
            if (onClearSearch != null) ...[
              SizedBox(height: 16.h),
              TextButton(
                onPressed: onClearSearch,
                child: AppText(
                  'Clear search',
                  style: AllTextStyle.f14W5.copyWith(
                    color: PrimitiveColors.primary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DefaultLoadingWidget extends StatelessWidget {
  const _DefaultLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(PrimitiveColors.primary),
      ),
    );
  }
}

class _DefaultErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _DefaultErrorWidget({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSize.allPadding16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48.w, color: PrimitiveColors.red),
            SizedBox(height: 16.h),
            AppText(
              error,
              style: AllTextStyle.f16W5.copyWith(color: PrimitiveColors.red),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            AppButton.primary(
              onPressed: onRetry,
              label: 'Retry',
              width: 120.w,
              height: 40.h,
            ),
          ],
        ),
      ),
    );
  }
}

class _DefaultEmptyWidget extends StatelessWidget {
  const _DefaultEmptyWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSize.allPadding16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 48.w,
              color: PrimitiveColors.hintText,
            ),
            SizedBox(height: 16.h),
            AppText(
              'No items found',
              style: AllTextStyle.f16W5.copyWith(
                color: PrimitiveColors.hintText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
