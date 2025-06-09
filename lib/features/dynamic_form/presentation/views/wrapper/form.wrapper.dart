import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/main.di.dart';
import '../../bloc/get/get_dynamic_form.bloc.dart';
import '../../bloc/post/post_dynamic_form.bloc.dart';

@RoutePage(name: 'FormWrapperRoute')
class FormWrapper extends StatelessWidget implements AutoRouteWrapper {
  const FormWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<GetDynamicFormBloc>()..add(const GetDynamicFormEvent()),
        ),
        BlocProvider(create: (context) => sl<PostDynamicFormBloc>()),
      ],
      child: this,
    );
  }
}
