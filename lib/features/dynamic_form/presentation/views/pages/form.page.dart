import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../../core/common/presentation/views/widgets/app_button.widget.dart';
import '../../../data/model/form.model.dart';
import '../../bloc/form_state/form_state.bloc.dart';
import '../../bloc/get/get_dynamic_form.bloc.dart';
import '../../bloc/post/post_dynamic_form.bloc.dart';
import '../widgets/form_debug.widget.dart';
import '../widgets/form_step.widget.dart';

@RoutePage(name: 'FormPageRoute')
class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  void _onSubmitForm(BuildContext context, FromModel form) {
    final formStateBloc = context.read<FormStateBloc>();
    final postFormBloc = context.read<PostDynamicFormBloc>();

    formStateBloc.add(ValidateFormEvent(formSteps: form.steps ?? []));

    final currentState = formStateBloc.state;
    if (currentState is FormStateLoaded && currentState.isValid) {
      final updatedForm = _createFormWithValues(form, currentState.formValues);
      postFormBloc.add(SubmitFormEvent(form: updatedForm));
    }
  }

  @override
  void initState() {
    super.initState();
    final formStateBloc = context.read<FormStateBloc>();
    formStateBloc.add(const ResetFormEvent());
  }

  FromModel _createFormWithValues(
    FromModel originalForm,
    Map<String, dynamic> formValues,
  ) {
    return originalForm;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetDynamicFormBloc, GetDynamicFormState>(
      listener: (context, state) {
        if (state is GetDynamicFormLoaded) {
          context.read<FormStateBloc>().add(
            InitializeFormEvent(formSteps: state.form?.steps ?? []),
          );
        }
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
            body: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: AppSize.allPadding16,
                    itemCount: (state.form?.steps?.length ?? 0),
                    separatorBuilder: (context, index) =>
                        AppSize.verticalMargin24,
                    itemBuilder: (context, index) {
                      return FormStepWidget(step: state.form!.steps![index]);
                    },
                  ),
                ),

                Container(
                  padding: AppSize.allPadding16,
                  child:
                      BlocConsumer<PostDynamicFormBloc, PostDynamicFormState>(
                        listener: (context, postState) {
                          if (postState is PostDynamicFormSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Form submitted successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            // Clear form values
                            context.read<FormStateBloc>().add(
                              const ResetFormEvent(),
                            );
                          } else if (postState is PostDynamicFormError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Error: ${postState.error.message}',
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        builder: (context, postState) {
                          return BlocBuilder<FormStateBloc, FormStateState>(
                            builder: (context, formState) {
                              final isLoading =
                                  postState is PostDynamicFormLoading;
                              final isValid =
                                  formState is FormStateLoaded &&
                                  formState.isValid;

                              return AppButton.primary(
                                onPressed: isLoading
                                    ? null
                                    : () => _onSubmitForm(context, state.form!),
                                label: 'Submit Form',
                                isLoading: isLoading,
                                isDisabled: !isValid,
                              );
                            },
                          );
                        },
                      ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
