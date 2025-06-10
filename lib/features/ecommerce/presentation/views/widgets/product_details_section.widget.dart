import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../config/constants/fonts/app_text_style.dart';
import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../../../data/models/product.model.dart';

class ProductDetailsSection extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'Product Details',
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
            children: [
              if (product.weight != null)
                _buildDetailRow('Weight', '${product.weight}g'),
              if (product.dimensions != null) ...[
                if (product.weight != null) AppSize.verticalMargin8,
                _buildDetailRow(
                  'Dimensions',
                  '${product.dimensions!.width} × ${product.dimensions!.height} × ${product.dimensions!.depth} cm',
                ),
              ],
              if (product.minimumOrderQuantity != null) ...[
                if (product.weight != null || product.dimensions != null)
                  AppSize.verticalMargin8,
                _buildDetailRow(
                  'Min. Order Quantity',
                  '${product.minimumOrderQuantity} units',
                ),
              ],
              if (product.availabilityStatus != null) ...[
                if (product.weight != null ||
                    product.dimensions != null ||
                    product.minimumOrderQuantity != null)
                  AppSize.verticalMargin8,
                _buildDetailRow('Availability', product.availabilityStatus!),
              ],
              if (product.tags != null && product.tags!.isNotEmpty) ...[
                AppSize.verticalMargin12,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      'Tags',
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    AppSize.verticalMargin8,
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: product.tags!.map((tag) {
                        return Container(
                          padding:
                              AppSize.horizontalPadding12 +
                              AppSize.verticalPadding6,
                          decoration: BoxDecoration(
                            color: PrimitiveColors.primary.withOpacity(0.1),
                            borderRadius: AppSize.allRadius16,
                            border: Border.all(
                              color: PrimitiveColors.primary.withOpacity(0.3),
                            ),
                          ),
                          child: AppText(
                            tag,
                            style: AppTextStyles.caption.copyWith(
                              color: PrimitiveColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                            translate: false,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        AppSize.verticalMargin16,
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: AppText(
            label,
            style: AppTextStyles.body.copyWith(color: PrimitiveColors.hintText),
          ),
        ),
        AppSize.horizontalMargin8,
        Expanded(
          flex: 3,
          child: AppText(
            value,
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500),
            translate: false,
          ),
        ),
      ],
    );
  }
}
