import 'package:flutter/material.dart';

import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../config/constants/fonts/app_text_style.dart';
import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../../../data/models/product.model.dart';

class ProductDescriptionSection extends StatelessWidget {
  final ProductModel product;

  const ProductDescriptionSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    if (product.description == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'Description',
          style: AppTextStyles.subheadline.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSize.verticalMargin8,
        Container(
          width: double.infinity,
          padding: AppSize.allPadding16,
          decoration: BoxDecoration(
            borderRadius: AppSize.allRadius12,
            color: PrimitiveColors.stroke.withOpacity(0.1),
          ),
          child: AppText(
            product.description!,
            style: AppTextStyles.body,
            translate: false,
          ),
        ),
        AppSize.verticalMargin16,
      ],
    );
  }
}
