import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../config/constants/fonts/all_text_styles.dart';
import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../common/presentation/views/widgets/app_text.widget.dart';
import '../../../../common/presentation/views/widgets/app_text_field.widget.dart';
import '../../bloc/pagination/mixins/searchable_pagination.bloc.dart';
import '../../bloc/pagination/pagination.bloc.dart';
import 'pagination_list_view.widget.dart';

/// A pagination ListView widget with search functionality
class SearchablePaginationListView<T> extends StatelessWidget {
  /// The searchable pagination bloc to use
  final PaginationBloc<T> bloc;

  /// Builder function for each item
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

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

  /// Search field placeholder text
  final String searchHint;

  /// Whether to show the search field
  final bool showSearchField;

  /// Search field prefix icon
  final IconData? searchPrefixIcon;

  /// Search field suffix icon
  final IconData? searchSuffixIcon;

  /// Custom styling for search field
  final InputDecoration? searchDecoration;

  const SearchablePaginationListView({
    super.key,
    required this.bloc,
    required this.itemBuilder,
    this.emptyWidget,
    this.noSearchResultsWidget,
    this.loadingWidget,
    this.errorBuilder,
    this.scrollController,
    this.showLoadMoreButton = false,
    this.separator,
    this.padding,
    this.enablePullToRefresh = true,
    this.refreshIndicatorColor,
    this.searchHint = 'Search...',
    this.showSearchField = true,
    this.searchPrefixIcon = Icons.search,
    this.searchSuffixIcon,
    this.searchDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showSearchField) _buildSearchField(context),
        Expanded(
          child: BlocBuilder<PaginationBloc<T>, PaginationState<T>>(
            bloc: bloc,
            builder: (context, state) {
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

              return PaginationListView<T>(
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
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField(BuildContext context) {
    if (bloc is! SearchablePaginationBloc<T>) {
      return const SizedBox.shrink();
    }

    final searchableBloc = bloc as SearchablePaginationBloc<T>;

    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
      child: AppTextField.search(
        controller: searchableBloc.searchController,
        hintText: searchHint,
      ),
    );
  }

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
