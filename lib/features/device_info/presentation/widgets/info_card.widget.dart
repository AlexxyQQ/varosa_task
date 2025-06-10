import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../config/constants/fonts/app_text_style.dart';
import '../../../../config/constants/size/app_size.constant.dart';
import '../../../../core/common/presentation/views/widgets/app_text.widget.dart';

class InfoCardWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const InfoCardWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSize.allPadding16,
      decoration: BoxDecoration(
        borderRadius: AppSize.allRadius12,
        border: Border.all(color: PrimitiveColors.stroke),
      ),
      child: Row(
        children: [
          Container(
            padding: AppSize.allPadding8,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: AppSize.allRadius8,
            ),
            child: Icon(icon, color: color, size: 20.r),
          ),
          AppSize.horizontalMargin16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  label,
                  translate: false,
                  style: AppTextStyles.subtitle.copyWith(
                    color: PrimitiveColors.onSecondaryDisabled,
                  ),
                ),
                AppSize.verticalMargin4,
                AppText(value, translate: false, style: AppTextStyles.body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
