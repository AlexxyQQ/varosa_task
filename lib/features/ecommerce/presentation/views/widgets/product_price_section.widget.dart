import 'package:flutter/material.dart';

import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../config/constants/fonts/app_text_style.dart';
import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../../../data/models/product.model.dart';

class ProductPriceSection extends StatelessWidget {
  final ProductModel product;

  const ProductPriceSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSize.allPadding16,
      decoration: BoxDecoration(
        borderRadius: AppSize.allRadius12,
        color: PrimitiveColors.primary.withOpacity(0.1),
        border: Border.all(color: PrimitiveColors.primary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.price != null) ...[
                  Row(
                    children: [
                      AppText(
                        '\$${product.price!.toStringAsFixed(2)}',
                        style: AppTextStyles.headline.copyWith(
                          color: PrimitiveColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        translate: false,
                      ),
                      if (product.discountPercentage != null &&
                          product.discountPercentage! > 0) ...[
                        AppSize.horizontalMargin8,
                        Container(
                          padding:
                              AppSize.horizontalPadding8 +
                              AppSize.verticalPadding4,
                          decoration: BoxDecoration(
                            color: PrimitiveColors.red,
                            borderRadius: AppSize.allRadius6,
                          ),
                          child: AppText(
                            '-${product.discountPercentage!.toStringAsFixed(0)}%',
                            style: AppTextStyles.caption.copyWith(
                              color: PrimitiveColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            translate: false,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (product.discountPercentage != null &&
                      product.discountPercentage! > 0) ...[
                    AppSize.verticalMargin4,
                    AppText(
                      'Original: \$${(product.price! / (1 - product.discountPercentage! / 100)).toStringAsFixed(2)}',
                      style: AppTextStyles.caption.copyWith(
                        color: PrimitiveColors.hintText,
                        decoration: TextDecoration.lineThrough,
                      ),
                      translate: false,
                    ),
                  ],
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (product.stock != null) ...[
                Container(
                  padding:
                      AppSize.horizontalPadding8 + AppSize.verticalPadding4,
                  decoration: BoxDecoration(
                    color: product.stock! > 0
                        ? PrimitiveColors.green
                        : PrimitiveColors.red,
                    borderRadius: AppSize.allRadius6,
                  ),
                  child: AppText(
                    product.stock! > 0 ? 'In Stock' : 'Out of Stock',
                    style: AppTextStyles.caption.copyWith(
                      color: PrimitiveColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AppSize.verticalMargin4,
                AppText(
                  '${product.stock} units',
                  style: AppTextStyles.caption.copyWith(
                    color: PrimitiveColors.hintText,
                  ),
                  translate: false,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
