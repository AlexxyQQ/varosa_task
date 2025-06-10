import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../config/constants/fonts/app_text_style.dart';
import '../../../../config/constants/size/app_size.constant.dart';
import '../../../../core/common/presentation/views/widgets/app_cached_network_image.dart';
import '../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../../data/models/product.model.dart';
import '../bloc/product.bloc.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: AppSize.allMargin16,
        decoration: BoxDecoration(
          borderRadius: AppSize.allRadius12,
          color: PrimitiveColors.white,
          border: Border.all(color: PrimitiveColors.stroke),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            AppCachedNetworkImage.custom(
              width: 1.sw,
              height: 200.h,
              imageUrl: product.thumbnail ?? '',
              alt: product.title ?? '',
            ),
            // Product Details
            Padding(
              padding: AppSize.allPadding16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Rating Row
                  _buildTitleAndRating(context),
                  AppSize.verticalMargin8,
                  // Category and Brand
                  _buildCategoryAndBrand(),
                  AppSize.verticalMargin12,
                  // Description
                  _buildDescription(),
                  AppSize.verticalMargin12,
                  // Price and Discount
                  _buildPriceSection(),
                  AppSize.verticalMargin8,
                  // Stock and Availability
                  _buildStockInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleAndRating(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Expanded(
          child: AppText(
            product.title ?? 'No Title',
            style: AppTextStyles.title,
            maxLines: 2,
            translate: false,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        AppSize.horizontalMargin8,
        if (product.rating != null) _buildRatingWidget(),
        Padding(
          padding: AppSize.horizontalPadding6 + AppSize.verticalPadding4,
          child: GestureDetector(
            onTap: () {
              context.read<ProductBloc>().add(
                AddToFavoriteEvent(product: product),
              );
            },
            child: Icon(
              size: 24.sp,
              product.isFavorite ?? false
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: product.isFavorite ?? false
                  ? PrimitiveColors.primary
                  : PrimitiveColors.onPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingWidget() {
    return Container(
      padding: AppSize.verticalPadding4 + AppSize.horizontalPadding8,
      decoration: BoxDecoration(
        color: PrimitiveColors.primary.withValues(alpha: 0.1),
        borderRadius: AppSize.allRadius6,
        border: Border.all(
          color: PrimitiveColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, size: 14.sp, color: PrimitiveColors.primary),
          AppSize.horizontalMargin4,
          AppText(
            product.rating!.toStringAsFixed(1),
            style: AppTextStyles.caption.copyWith(
              color: PrimitiveColors.onPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryAndBrand() {
    return Row(
      children: [
        if (product.category != null) ...[
          Container(
            padding: AppSize.verticalPadding4 + AppSize.horizontalPadding8,
            decoration: BoxDecoration(
              color: PrimitiveColors.blue.withValues(alpha: 0.1),
              borderRadius: AppSize.allRadius6,
            ),
            child: AppText(
              product.category!.toUpperCase(),
              translate: false,
              style: AppTextStyles.caption.copyWith(
                color: PrimitiveColors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          AppSize.horizontalMargin8,
        ],
        if (product.brand != null)
          Expanded(
            child: AppText(
              'Brand: ${product.brand}',
              style: AppTextStyles.subtitle,
              translate: false,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }

  Widget _buildDescription() {
    if (product.description == null) return const SizedBox.shrink();

    return AppText(
      product.description!,
      style: AppTextStyles.body,
      maxLines: 3,
      translate: false,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildPriceSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (product.price != null) ...[
          AppText(
            '\$${product.price!.toStringAsFixed(2)}',
            style: AppTextStyles.headline.copyWith(
              color: PrimitiveColors.green,
              fontWeight: FontWeight.bold,
            ),
            translate: false,
          ),
          AppSize.horizontalMargin8,
        ],
        if (product.discountPercentage != null &&
            product.discountPercentage! > 0) ...[
          Container(
            padding: AppSize.verticalPadding2 + AppSize.horizontalPadding6,
            decoration: BoxDecoration(
              color: PrimitiveColors.red.withValues(alpha: 0.1),
              borderRadius: AppSize.allRadius6,
            ),
            child: AppText(
              '${product.discountPercentage!.toStringAsFixed(0)}% OFF',
              translate: false,
              style: AppTextStyles.caption.copyWith(
                color: PrimitiveColors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStockInfo() {
    return Row(
      children: [
        if (product.stock != null) ...[
          Icon(
            Icons.inventory_2_outlined,
            size: 16.sp,
            color: PrimitiveColors.onPrimary,
          ),
          AppSize.horizontalMargin4,
          AppText(
            'Stock: ${product.stock}',
            style: AppTextStyles.subtitle,
            translate: false,
          ),
          AppSize.horizontalMargin16,
        ],
        if (product.availabilityStatus != null) ...[
          Container(
            width: 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: _getAvailabilityColor(),
              shape: BoxShape.circle,
            ),
          ),
          AppSize.horizontalMargin6,
          AppText(
            product.availabilityStatus!,
            translate: false,
            style: AppTextStyles.subtitle.copyWith(
              color: _getAvailabilityColor(),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Color _getAvailabilityColor() {
    if (product.availabilityStatus?.toLowerCase().contains('in stock') ==
        true) {
      return PrimitiveColors.green;
    } else if (product.availabilityStatus?.toLowerCase().contains(
          'low stock',
        ) ==
        true) {
      return Colors.orange;
    } else {
      return PrimitiveColors.red;
    }
  }
}
