import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../config/constants/fonts/app_text_style.dart';
import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../../../data/models/product.model.dart';

class ProductRatingSection extends StatelessWidget {
  final ProductModel product;

  const ProductRatingSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    if (product.rating == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        Container(
          padding: AppSize.allPadding12,
          decoration: BoxDecoration(
            borderRadius: AppSize.allRadius8,
            border: Border.all(color: PrimitiveColors.stroke),
          ),
          child: Row(
            children: [
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < product.rating!.floor()
                        ? Icons.star
                        : index < product.rating!
                        ? Icons.star_half
                        : Icons.star_border,
                    color: PrimitiveColors.orange,
                    size: 20.w,
                  );
                }),
              ),
              AppSize.horizontalMargin8,
              AppText(
                '${product.rating!.toStringAsFixed(1)}',
                style: AppTextStyles.subheadline.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                translate: false,
              ),
              AppSize.horizontalMargin4,
              AppText(
                'out of 5',
                style: AppTextStyles.body.copyWith(
                  color: PrimitiveColors.hintText,
                ),
              ),
              if (product.reviews != null) ...[
                AppSize.horizontalMargin8,
                AppText(
                  '(${product.reviews!.length} review${product.reviews!.length != 1 ? 's' : ''})',
                  style: AppTextStyles.body.copyWith(
                    color: PrimitiveColors.hintText,
                  ),
                  translate: false,
                ),
              ],
            ],
          ),
        ),
        AppSize.verticalMargin16,
      ],
    );
  }
}
