import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../../bloc/get/get_dynamic_form.bloc.dart';
import '../widgets/form_step.widget.dart';

@RoutePage(name: 'FormPageRoute')
class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetDynamicFormBloc, GetDynamicFormState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is GetDynamicFormLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetDynamicFormError) {
          return Center(child: Text(state.error.message));
        }

        if (state is GetDynamicFormLoaded) {
          return Scaffold(
            appBar: AppBar(title: Text(state.form?.title ?? '')),
            body: ListView.separated(
              padding: AppSize.allPadding16,
              itemCount: state.form?.steps?.length ?? 0,
              separatorBuilder: (context, index) => AppSize.verticalMargin24,
              itemBuilder: (context, index) {
                return FormStepWidget(step: state.form!.steps![index]!);
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
