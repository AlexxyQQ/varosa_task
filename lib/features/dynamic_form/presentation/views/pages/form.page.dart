import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../../bloc/get/get_dynamic_form.bloc.dart';

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
            body: AppText("${state.form?.steps?[0].title}"),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}


