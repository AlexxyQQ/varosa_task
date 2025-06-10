import 'package:flutter/material.dart';

import '../../../../config/constants/size/app_size.constant.dart';
import '../../data/models/product.model.dart';
import 'product_info_card.widget.dart';

class ProductCategoryBrandSection extends StatelessWidget {
  final ProductModel product;

  const ProductCategoryBrandSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (product.category != null) ...[
          Expanded(
            child: ProductInfoCard(
              title: 'Category',
              value: product.category!,
              icon: Icons.category,
            ),
          ),
        ],
        if (product.category != null && product.brand != null)
          AppSize.horizontalMargin12,
        if (product.brand != null) ...[
          Expanded(
            child: ProductInfoCard(
              title: 'Brand',
              value: product.brand!,
              icon: Icons.branding_watermark,
            ),
          ),
        ],
      ],
    );
  }
}
