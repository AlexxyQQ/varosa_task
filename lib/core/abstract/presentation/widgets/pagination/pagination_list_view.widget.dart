import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../config/constants/fonts/all_text_styles.dart';
import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../common/presentation/views/widgets/app_button.widget.dart';
import '../../../../common/presentation/views/widgets/app_text.widget.dart';
import '../../bloc/pagination/pagination.bloc.dart';

/// A generic pagination ListView widget that works with any PaginationBloc
class PaginationListView<T> extends StatefulWidget {
  /// The pagination bloc to use
  final PaginationBloc<T> bloc;

  /// Builder function for each item
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

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

  const PaginationListView({
    super.key,
    required this.bloc,
    required this.itemBuilder,
    this.emptyWidget,
    this.loadingWidget,
    this.errorBuilder,
    this.scrollController,
    this.showLoadMoreButton = false,
    this.separator,
    this.padding,
    this.enablePullToRefresh = true,
    this.refreshIndicatorColor,
  });

  @override
  State<PaginationListView<T>> createState() => _PaginationListViewState<T>();
}

class _PaginationListViewState<T> extends State<PaginationListView<T>> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();

    // Add scroll listener only when load more button is hidden
    if (!widget.showLoadMoreButton) {
      _scrollController.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    if (!widget.showLoadMoreButton) {
      _scrollController.removeListener(_onScroll);
    }
    // Only dispose if we created the controller
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      final state = widget.bloc.state;
      if (!state.hasReachedNextEnd && !state.isLoadingNext) {
        widget.bloc.add(const LoadNextPaginationEvent());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaginationBloc<T>, PaginationState<T>>(
      bloc: widget.bloc,
      builder: (context, state) {
        if (state.isLoading && state.items.isEmpty) {
          return widget.loadingWidget ?? const _DefaultLoadingWidget();
        }

        if (state.error != null && state.items.isEmpty) {
          return widget.errorBuilder?.call(context, state.error!.message) ??
              _DefaultErrorWidget(
                error: state.error!.message,
                onRetry: () => widget.bloc.add(const RefreshPaginationEvent()),
              );
        }

        if (state.items.isEmpty) {
          return widget.emptyWidget ?? const _DefaultEmptyWidget();
        }

        // Calculate item count - add 1 for load more button if needed
        int itemCount = state.items.length;
        if (widget.showLoadMoreButton && !state.hasReachedNextEnd) {
          itemCount++;
        }

        Widget listView = ListView.separated(
          controller: _scrollController,
          padding: widget.padding ?? AppSize.allPadding16,
          itemCount: itemCount,
          separatorBuilder: (context, index) =>
              widget.separator ?? SizedBox(height: 8.h),
          itemBuilder: (context, index) {
            // If this is the load more button position
            if (widget.showLoadMoreButton && index == state.items.length) {
              return _LoadMoreButton(bloc: widget.bloc, state: state);
            }

            // Return the actual item
            return widget.itemBuilder(context, state.items[index], index);
          },
        );

        if (widget.enablePullToRefresh) {
          listView = RefreshIndicator(
            color: widget.refreshIndicatorColor ?? PrimitiveColors.primary,
            onRefresh: () async {
              widget.bloc.add(const RefreshPaginationEvent());
              // Wait for the refresh to complete
              await widget.bloc.stream
                  .firstWhere((state) => !state.isLoading)
                  .timeout(const Duration(seconds: 10));
            },
            child: listView,
          );
        }

        return Stack(
          children: [
            listView,
            if (state.isLoadingNext && !widget.showLoadMoreButton)
              const Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: _LoadingIndicator(),
              ),
          ],
        );
      },
    );
  }
}

class _LoadMoreButton<T> extends StatelessWidget {
  final PaginationBloc<T> bloc;
  final PaginationState<T> state;

  const _LoadMoreButton({required this.bloc, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.hasReachedNextEnd) {
      return Container(
        padding: AppSize.allPadding16,
        alignment: Alignment.center,
        child: AppText(
          'No more items',
          style: AllTextStyle.f14W5.copyWith(color: PrimitiveColors.hintText),
        ),
      );
    }

    return Container(
      padding: AppSize.allPadding16,
      child: AppButton.stroke(
        onPressed: () => bloc.add(const LoadNextPaginationEvent()),
        label: 'Load More',
        isLoading: state.isLoadingNext,
        height: 40.h,
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: AppSize.allPadding8,
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
        child: SizedBox(
          width: 20.w,
          height: 20.h,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(PrimitiveColors.primary),
          ),
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
