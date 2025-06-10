import 'package:flutter/material.dart';

import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../config/constants/fonts/app_text_style.dart';
import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../../../data/models/product.model.dart';

class ProductTitleSection extends StatelessWidget {
  final ProductModel product;

  const ProductTitleSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          product.title ?? 'No Title',
          style: AppTextStyles.headline.copyWith(fontWeight: FontWeight.bold),
          translate: false,
        ),
        if (product.sku != null) ...[
          AppSize.verticalMargin4,
          AppText(
            'SKU: ${product.sku}',
            style: AppTextStyles.caption.copyWith(
              color: PrimitiveColors.hintText,
            ),
            translate: false,
          ),
        ],
      ],
    );
  }
}
