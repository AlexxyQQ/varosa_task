import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../config/constants/fonts/app_text_style.dart';
import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../../bloc/form_state/form_state.bloc.dart';

class FormDebugWidget extends StatelessWidget {
  const FormDebugWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormStateBloc, FormStateState>(
      builder: (context, state) {
        if (state is! FormStateLoaded) {
          return const SizedBox.shrink();
        }

        return Container(
          margin: AppSize.allMargin16,
          padding: AppSize.allPadding12,
          decoration: BoxDecoration(
            color: PrimitiveColors.stroke.withOpacity(0.1),
            border: Border.all(color: PrimitiveColors.stroke),
            borderRadius: AppSize.allRadius8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                'Form State Debug',
                style: AppTextStyles.subtitle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSize.verticalMargin8,
              AppText(
                'Form Values:',
                style: AppTextStyles.caption.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              ...state.formValues.entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(left: 8, top: 4),
                  child: AppText(
                    '${entry.key}: ${entry.value}',
                    style: AppTextStyles.caption,
                  ),
                ),
              ),
              if (state.errors.isNotEmpty) ...[
                AppSize.verticalMargin8,
                AppText(
                  'Errors:',
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: FontWeight.w500,
                    color: PrimitiveColors.red,
                  ),
                ),
                ...state.errors.entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(left: 8, top: 4),
                    child: AppText(
                      '${entry.key}: ${entry.value}',
                      style: AppTextStyles.caption.copyWith(
                        color: PrimitiveColors.red,
                      ),
                    ),
                  ),
                ),
              ],
              AppSize.verticalMargin8,
              AppText(
                'Form Valid: ${state.isValid ? 'Yes' : 'No'}',
                style: AppTextStyles.caption.copyWith(
                  fontWeight: FontWeight.w500,
                  color: state.isValid
                      ? PrimitiveColors.green
                      : PrimitiveColors.red,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
