import 'package:flutter/material.dart';

import '../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../config/constants/fonts/app_text_style.dart';
import '../../../../config/constants/size/app_size.constant.dart';
import '../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../../data/models/product.model.dart';
import 'product_review_card.widget.dart';

class ProductReviewsSection extends StatelessWidget {
  final ProductModel product;

  const ProductReviewsSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    if (product.reviews == null || product.reviews!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSize.verticalMargin8,
        AppText(
          'Customer Reviews',
          style: AppTextStyles.subheadline.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSize.verticalMargin12,
        ...product.reviews!
            .take(3)
            .map((review) => ProductReviewCard(review: review)),
        if (product.reviews!.length > 3) ...[
          AppSize.verticalMargin12,
          Center(
            child: AppText(
              'and ${product.reviews!.length - 3} more review${product.reviews!.length - 3 != 1 ? 's' : ''}',
              style: AppTextStyles.body.copyWith(
                color: PrimitiveColors.hintText,
                fontStyle: FontStyle.italic,
              ),
              translate: false,
            ),
          ),
        ],
      ],
    );
  }
}
