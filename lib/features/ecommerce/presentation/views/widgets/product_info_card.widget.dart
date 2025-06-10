import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../config/constants/fonts/app_text_style.dart';
import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../../core/common/presentation/views/widgets/app_text.widget.dart';

class ProductInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ProductInfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSize.allPadding12,
      decoration: BoxDecoration(
        borderRadius: AppSize.allRadius8,
        border: Border.all(color: PrimitiveColors.stroke),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20.w, color: PrimitiveColors.primary),
          AppSize.horizontalMargin8,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  title,
                  style: AppTextStyles.caption.copyWith(
                    color: PrimitiveColors.hintText,
                  ),
                ),
                AppText(
                  value,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  translate: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
