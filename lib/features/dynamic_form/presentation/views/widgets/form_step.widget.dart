import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/constants/fonts/app_text_style.dart';
import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../../../data/model/form_step.model.dart';
import '../../bloc/form_state/form_state.bloc.dart';
import 'form_input.widget.dart';

class FormStepWidget extends StatelessWidget {
  const FormStepWidget({super.key, required this.step});
  final FormStepModel step;

  @override
  Widget build(BuildContext context) {
    if (step.inputs?.isEmpty ?? true) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(step.title ?? '', style: AppTextStyles.title),
        AppSize.verticalMargin10,

        ...step.inputs!.map(
          (e) => Padding(
            padding: AppSize.verticalPadding6,
            child: FormInputWidget(
              input: e,
              onChanged: (value) {
                context.read<FormStateBloc>().add(
                  ValidateFormEvent(formSteps: [step]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
