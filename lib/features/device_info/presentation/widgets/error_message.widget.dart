import 'package:flutter/material.dart';

import '../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../config/constants/fonts/app_text_style.dart';
import '../../../../config/constants/size/app_size.constant.dart';
import '../../../../core/common/presentation/views/widgets/app_text.widget.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String message;

  const ErrorMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSize.allPadding16,
      decoration: BoxDecoration(
        borderRadius: AppSize.allRadius12,
        border: Border.all(color: PrimitiveColors.red),
      ),
      child: Row(
        children: [
          const Icon(Icons.error, color: PrimitiveColors.red),
          AppSize.horizontalMargin12,
          Expanded(
            child: AppText(
              message,
              translate: false,
              style: AppTextStyles.body.copyWith(color: PrimitiveColors.red),
            ),
          ),
        ],
      ),
    );
  }
}
