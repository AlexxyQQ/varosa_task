import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../config/constants/fonts/app_text_style.dart';
import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../../../data/models/product.model.dart';

class ProductShippingWarrantySection extends StatelessWidget {
  final ProductModel product;

  const ProductShippingWarrantySection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    if (product.shippingInformation == null &&
        product.warrantyInformation == null &&
        product.returnPolicy == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'Shipping & Warranty',
          style: AppTextStyles.subheadline.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSize.verticalMargin12,
        Container(
          width: double.infinity,
          padding: AppSize.allPadding16,
          decoration: BoxDecoration(
            borderRadius: AppSize.allRadius12,
            border: Border.all(color: PrimitiveColors.stroke),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (product.shippingInformation != null) ...[
                _buildInfoItem(
                  Icons.local_shipping,
                  'Shipping',
                  product.shippingInformation!,
                ),
              ],
              if (product.warrantyInformation != null) ...[
                if (product.shippingInformation != null)
                  AppSize.verticalMargin12,
                _buildInfoItem(
                  Icons.verified_user,
                  'Warranty',
                  product.warrantyInformation!,
                ),
              ],
              if (product.returnPolicy != null) ...[
                if (product.shippingInformation != null ||
                    product.warrantyInformation != null)
                  AppSize.verticalMargin12,
                _buildInfoItem(
                  Icons.keyboard_return,
                  'Return Policy',
                  product.returnPolicy!,
                ),
              ],
            ],
          ),
        ),
        AppSize.verticalMargin16,
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20.w, color: PrimitiveColors.primary),
        AppSize.horizontalMargin12,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                title,
                style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500),
              ),
              AppSize.verticalMargin4,
              AppText(
                content,
                style: AppTextStyles.body.copyWith(
                  color: PrimitiveColors.hintText,
                ),
                translate: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
