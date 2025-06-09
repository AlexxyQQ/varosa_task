import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../config/constants/fonts/app_text_style.dart';
import '../../../../../core/common/presentation/views/styles/form.style.dart';
import '../../../../../core/common/presentation/views/widgets/app_dropdown.widget.dart';
import '../../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../../../../../core/common/presentation/views/widgets/app_text_field.widget.dart';
import '../../../data/enum/input_type.enum.dart';
import '../../../data/model/form_input.model.dart';

class FormInputWidget extends StatelessWidget {
  const FormInputWidget({super.key, required this.input});
  final FormInputModel input;

  @override
  Widget build(BuildContext context) {
    return switch (input.type) {
      InputType.text => AppTextField.custom(
        onChanged: (value) {},
        titleText: input.label ?? '',
        hintText: input.label ?? '',
      ),
      InputType.dropdown => AppDropdown<String>(
        titleText: input.label ?? '',
        hintText: input.label ?? '',
        onChanged: (value) {},
        items:
            input.options
                ?.map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: AppText(
                      e,
                      style: AppTextStyles.body.copyWith(
                        color: PrimitiveColors.black,
                      ),
                    ),
                  ),
                )
                .toList() ??
            [],
      ),
      InputType.number => AppTextField.custom(
        onChanged: (value) {},
        titleText: input.label ?? '',
        hintText: input.label ?? '',
        theme: FormStyles.getTheme(null).copyWith(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
      ),
      InputType.email => AppTextField.custom(
        onChanged: (value) {},
        titleText: input.label ?? '',
        hintText: input.label ?? '',
        theme: FormStyles.getTheme(
          null,
        ).copyWith(keyboardType: TextInputType.emailAddress),
      ),
      InputType.phone => AppTextField.custom(
        onChanged: (value) {},
        titleText: input.label ?? '',
        hintText: input.label ?? '',
        theme: FormStyles.getTheme(
          null,
        ).copyWith(keyboardType: TextInputType.phone),
      ),

      _ => const SizedBox.shrink(),
    };
  }
}
