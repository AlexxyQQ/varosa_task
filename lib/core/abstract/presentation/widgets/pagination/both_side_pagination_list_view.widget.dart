import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../config/constants/fonts/all_text_styles.dart';
import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../common/presentation/views/widgets/app_button.widget.dart';
import '../../../../common/presentation/views/widgets/app_text.widget.dart';
import '../../bloc/pagination/mixins/both_side_pagination.bloc.dart';
import '../../bloc/pagination/pagination.bloc.dart';
import 'pagination_types.dart';

/// A pagination ListView widget that supports loading in both directions
class BothSidePaginationListView<T> extends StatefulWidget {
  /// The both-side pagination bloc to use
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

  /// Whether to show pagination controls
  final bool showPaginationControls;

  /// Whether to show page info
  final bool showPageInfo;

  /// Custom pagination controls position
  final PaginationControlsPosition controlsPosition;

  /// Whether to show the previous button
  final bool showPreviousButton;

  /// Whether to show the refresh button
  final bool showRefreshButton;

  /// Whether to show the next button
  final bool showNextButton;

  const BothSidePaginationListView({
    super.key,
    required this.bloc,
    required this.itemBuilder,
    this.emptyWidget,
    this.loadingWidget,
    this.errorBuilder,
    this.scrollController,
    this.showLoadMoreButtons = false,
    this.separator,
    this.padding,
    this.enablePullToRefresh = true,
    this.refreshIndicatorColor,
    this.showPaginationControls = false,
    this.showPageInfo = true,
    this.controlsPosition = PaginationControlsPosition.bottom,
    this.showPreviousButton = true,
    this.showRefreshButton = true,
    this.showNextButton = true,
  });

  @override
  State<BothSidePaginationListView<T>> createState() =>
      _BothSidePaginationListViewState<T>();
}

class _BothSidePaginationListViewState<T>
    extends State<BothSidePaginationListView<T>> {
  late ScrollController _scrollController;
  bool _hasScrolled = false;
  bool _hasScrolledTowardsTop = false;
  double _lastScrollOffset = 0.0;
  bool _isInitialLoad = true;

  // Track previous loading state to handle scroll position adjustment
  bool _isLoadingPrevious = false;
  double _scrollOffsetBeforeLoadPrevious = 0.0;
  int _itemCountBeforeLoadPrevious = 0;
  bool _shouldAdjustScrollPosition = false;

  // Prevent immediate re-triggering after scroll adjustment
  DateTime? _lastScrollAdjustmentTime;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_onScroll);

    // Mark initial load as complete after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _isInitialLoad = false;
        });
      }
    });
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    } else {
      _scrollController.removeListener(_onScroll);
    }
    super.dispose();
  }

  void _onScroll() {
    final currentOffset = _scrollController.offset;

    // Track if user has scrolled at all
    if (!_hasScrolled && currentOffset != _lastScrollOffset) {
      _hasScrolled = true;
    }

    // Track if user has scrolled towards the top
    // Only track this if we're not currently loading previous items
    if (_hasScrolled &&
        currentOffset < _lastScrollOffset &&
        currentOffset < 100 &&
        !_isLoadingPrevious) {
      _hasScrolledTowardsTop = true;
    }

    _lastScrollOffset = currentOffset;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.showPaginationControls &&
            widget.controlsPosition == PaginationControlsPosition.top)
          _buildPaginationControls(context),
        Expanded(child: _buildList(context)),
        if (widget.showPaginationControls &&
            widget.controlsPosition == PaginationControlsPosition.bottom)
          _buildPaginationControls(context),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    return BlocBuilder<PaginationBloc<T>, PaginationState<T>>(
      bloc: widget.bloc,
      builder: (context, state) {
        // Handle scroll position adjustment after loading previous items
        _handleScrollPositionAdjustment(state);

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

        int itemCount = state.items.length;
        if (widget.showLoadMoreButtons) {
          // Add space for previous button if can load previous (only for offset pagination)
          if (_canLoadPrevious(state) && !_isCursorPagination()) itemCount++;
          // Add space for next button if can load next
          if (_canLoadNext(state)) itemCount++;
        }

        Widget listView = ListView.separated(
          controller: _scrollController,
          padding: widget.padding ?? AppSize.allPadding16,
          itemCount: itemCount,
          separatorBuilder: (context, index) =>
              widget.separator ?? SizedBox(height: 8.h),
          itemBuilder: (context, index) {
            if (widget.showLoadMoreButtons) {
              // Previous button at the top (only for offset pagination)
              if (index == 0 &&
                  _canLoadPrevious(state) &&
                  !_isCursorPagination()) {
                return _LoadPreviousButton(bloc: widget.bloc, state: state);
              }

              // Adjust index for items based on whether previous button is shown
              final hasPreviousButton =
                  _canLoadPrevious(state) && !_isCursorPagination();
              final adjustedIndex = hasPreviousButton ? index - 1 : index;

              // Check if this is the next button
              if (adjustedIndex >= state.items.length) {
                return _LoadNextButton(bloc: widget.bloc, state: state);
              }

              return widget.itemBuilder(
                context,
                state.items[adjustedIndex],
                adjustedIndex,
              );
            } else {
              // Only auto-load previous if user has scrolled towards top, we're not in initial load,
              // not currently loading previous, and not about to adjust scroll position
              if (!_isInitialLoad &&
                  _hasScrolledTowardsTop &&
                  index <= 1 &&
                  !state.isLoadingPrevious &&
                  !_isLoadingPrevious &&
                  !_shouldAdjustScrollPosition &&
                  !_isCursorPagination() &&
                  _scrollController.offset < 50 &&
                  _canTriggerLoadPrevious()) {
                _triggerLoadPrevious(state);
              }

              // Auto-load next when near the end (keep existing logic)
              if (index >= state.items.length - 3 && !state.isLoadingNext) {
                _triggerLoadNext(state);
              }

              return widget.itemBuilder(context, state.items[index], index);
            }
          },
        );

        if (widget.enablePullToRefresh) {
          // Only enable pull-to-refresh if there are no previous items to load
          // This prevents conflict with loading previous items on pull down
          final shouldEnablePullToRefresh =
              !_canLoadPrevious(state) || _isCursorPagination();

          if (shouldEnablePullToRefresh) {
            listView = RefreshIndicator(
              color: widget.refreshIndicatorColor ?? PrimitiveColors.primary,
              onRefresh: () async {
                widget.bloc.add(const RefreshPaginationEvent());
                // Reset scroll tracking on refresh
                _resetScrollTracking();
                // Wait for the refresh to complete
                await widget.bloc.stream
                    .firstWhere((state) => !state.isLoading)
                    .timeout(const Duration(seconds: 10));
              },
              child: listView,
            );
          }
        }

        return Stack(
          children: [
            listView,
            if (state.isLoadingPrevious && !widget.showLoadMoreButtons)
              const Positioned(
                top: 16,
                left: 0,
                right: 0,
                child: _LoadingIndicator(text: 'Loading previous...'),
              ),
            if (state.isLoadingNext && !widget.showLoadMoreButtons)
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

  Widget _buildPaginationControls(BuildContext context) {
    return BlocBuilder<PaginationBloc<T>, PaginationState<T>>(
      bloc: widget.bloc,
      builder: (context, state) {
        if (widget.bloc is! BothSidePaginationBloc<T>) {
          return const SizedBox.shrink();
        }

        final bothSideBloc = widget.bloc as BothSidePaginationBloc<T>;

        // For cursor-based pagination, hide previous button since it's not supported
        final shouldShowPrevious =
            widget.showPreviousButton && !bothSideBloc.isCursorPagination;

        return Container(
          padding: AppSize.allPadding16,
          decoration: BoxDecoration(
            color: PrimitiveColors.white,
            border: Border(
              top: widget.controlsPosition == PaginationControlsPosition.bottom
                  ? const BorderSide(color: PrimitiveColors.stroke)
                  : BorderSide.none,
              bottom: widget.controlsPosition == PaginationControlsPosition.top
                  ? const BorderSide(color: PrimitiveColors.stroke)
                  : BorderSide.none,
            ),
          ),
          child: Column(
            children: [
              if (widget.showPageInfo) _buildPageInfo(bothSideBloc),
              if (widget.showPageInfo) SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (shouldShowPrevious) ...[
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
                    if (widget.showRefreshButton || widget.showNextButton)
                      SizedBox(width: 16.w),
                  ],
                  if (widget.showRefreshButton) ...[
                    Expanded(
                      child: AppButton.primary(
                        onPressed: () =>
                            widget.bloc.add(const RefreshPaginationEvent()),
                        label: 'Refresh',
                        isLoading: state.isLoading,
                        height: 40.h,
                      ),
                    ),
                    if (widget.showNextButton) SizedBox(width: 16.w),
                  ],
                  if (widget.showNextButton)
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
    // Show different info for cursor vs offset pagination
    if (bothSideBloc.isCursorPagination) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            '${bothSideBloc.totalItemsCount} items loaded',
            style: AllTextStyle.f12W4.copyWith(color: PrimitiveColors.hintText),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            'Page ${bothSideBloc.currentPage} • ${bothSideBloc.totalItemsCount} items loaded',
            style: AllTextStyle.f12W4.copyWith(color: PrimitiveColors.hintText),
          ),
        ],
      );
    }
  }

  bool _canLoadPrevious(PaginationState<T> state) {
    if (widget.bloc is! BothSidePaginationBloc<T>) return false;
    return (widget.bloc as BothSidePaginationBloc<T>).canLoadPrevious;
  }

  bool _canLoadNext(PaginationState<T> state) {
    if (widget.bloc is! BothSidePaginationBloc<T>) return false;
    return (widget.bloc as BothSidePaginationBloc<T>).canLoadNext;
  }

  bool _isCursorPagination() {
    if (widget.bloc is! BothSidePaginationBloc<T>) return false;
    return (widget.bloc as BothSidePaginationBloc<T>).isCursorPagination;
  }

  void _triggerLoadPrevious(PaginationState<T> state) {
    if (widget.bloc is BothSidePaginationBloc<T>) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        (widget.bloc as BothSidePaginationBloc<T>).loadPrevious();
      });
    }
  }

  void _triggerLoadNext(PaginationState<T> state) {
    if (widget.bloc is BothSidePaginationBloc<T>) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        (widget.bloc as BothSidePaginationBloc<T>).loadNext();
      });
    }
  }

  void _handleScrollPositionAdjustment(PaginationState<T> state) {
    // Track when loading previous starts
    if (state.isLoadingPrevious && !_isLoadingPrevious) {
      _isLoadingPrevious = true;
      _scrollOffsetBeforeLoadPrevious = _scrollController.offset;
      _itemCountBeforeLoadPrevious = state.items.length;
      _shouldAdjustScrollPosition = true;
    }

    // Track when loading previous ends and adjust scroll position
    if (_isLoadingPrevious &&
        !state.isLoadingPrevious &&
        _shouldAdjustScrollPosition) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _scrollController.hasClients) {
          // Calculate how many new items were added
          final newItemsCount =
              state.items.length - _itemCountBeforeLoadPrevious;

          if (newItemsCount > 0) {
            // Get current scroll metrics
            final scrollPosition = _scrollController.position;

            // Calculate average item height based on existing content
            double estimatedItemHeight = 80.0; // Default fallback

            if (scrollPosition.maxScrollExtent > 0 &&
                _itemCountBeforeLoadPrevious > 0) {
              // Calculate average item height based on existing content
              final totalContentHeight =
                  scrollPosition.maxScrollExtent +
                  scrollPosition.viewportDimension;
              estimatedItemHeight =
                  totalContentHeight / _itemCountBeforeLoadPrevious;
            }

            // Add separator height
            const separatorHeight = 8.0;
            final totalNewItemsHeight =
                newItemsCount * (estimatedItemHeight + separatorHeight);

            // Adjust scroll position to maintain user's view
            final newScrollOffset =
                _scrollOffsetBeforeLoadPrevious + totalNewItemsHeight;

            // Ensure we don't scroll beyond the new max extent
            final maxScrollExtent = scrollPosition.maxScrollExtent;
            final targetOffset = newScrollOffset.clamp(0.0, maxScrollExtent);

            // Smooth animation to new position
            _scrollController
                .animateTo(
                  targetOffset,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                )
                .then((_) {
                  // Additional safety: ensure scroll tracking is reset after animation
                  if (mounted) {
                    _hasScrolledTowardsTop = false;
                    _lastScrollAdjustmentTime = DateTime.now();
                  }
                });
          }

          // Reset tracking variables
          _isLoadingPrevious = false;
          _shouldAdjustScrollPosition = false;
          _scrollOffsetBeforeLoadPrevious = 0.0;
          _itemCountBeforeLoadPrevious = 0;
        }
      });
    }
  }

  bool _canTriggerLoadPrevious() {
    // Prevent triggering for 1 second after scroll adjustment to avoid immediate re-triggering
    if (_lastScrollAdjustmentTime != null) {
      final timeDifference = DateTime.now().difference(
        _lastScrollAdjustmentTime!,
      );
      return timeDifference.inMilliseconds > 1000;
    }
    return true;
  }

  void _resetScrollTracking() {
    _hasScrolled = false;
    _hasScrolledTowardsTop = false;
    _lastScrollOffset = 0.0;
    _isLoadingPrevious = false;
    _scrollOffsetBeforeLoadPrevious = 0.0;
    _itemCountBeforeLoadPrevious = 0;
    _shouldAdjustScrollPosition = false;
    _lastScrollAdjustmentTime = null;
  }
}

class _LoadPreviousButton<T> extends StatelessWidget {
  final PaginationBloc<T> bloc;
  final PaginationState<T> state;

  const _LoadPreviousButton({required this.bloc, required this.state});

  @override
  Widget build(BuildContext context) {
    if (bloc is! BothSidePaginationBloc<T>) {
      return const SizedBox.shrink();
    }

    final bothSideBloc = bloc as BothSidePaginationBloc<T>;

    // Don't show previous button for cursor pagination
    if (bothSideBloc.isCursorPagination) {
      return const SizedBox.shrink();
    }

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
    if (bloc is! BothSidePaginationBloc<T>) {
      return const SizedBox.shrink();
    }

    final bothSideBloc = bloc as BothSidePaginationBloc<T>;

    if (!bothSideBloc.canLoadNext) {
      return Container(
        padding: AppSize.allPadding16,
        alignment: Alignment.center,
        child: AppText(
          bothSideBloc.isCursorPagination ? 'No more items' : 'End of list',
          style: AllTextStyle.f14W5.copyWith(color: PrimitiveColors.hintText),
        ),
      );
    }

    return Container(
      padding: AppSize.allPadding16,
      child: AppButton.stroke(
        onPressed: () => bothSideBloc.loadNext(),
        label: bothSideBloc.isCursorPagination ? 'Load More' : 'Load Next',
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
