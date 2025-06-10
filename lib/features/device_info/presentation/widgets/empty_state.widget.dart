import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../config/constants/fonts/app_text_style.dart';
import '../../../../config/constants/size/app_size.constant.dart';
import '../../../../core/common/presentation/views/widgets/app_text.widget.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 64.r, color: PrimitiveColors.black),
            AppSize.verticalMargin16,
            AppText(
              'Tap the button above to fetch device information',
              translate: false,
              style: AppTextStyles.body,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
