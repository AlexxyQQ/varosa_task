import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/abstract/presentation/bloc/pagination/pagination.bloc.dart';
import '../../../../../core/di/main.di.dart';
import '../../bloc/product.bloc.dart';

@RoutePage(name: 'ECommerceWrapperRoute')
class ECommerceWrapper extends StatelessWidget implements AutoRouteWrapper {
  const ECommerceWrapper({super.key});

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
              sl<ProductBloc>()..add(const LoadInitialPaginationEvent()),
        ),
      ],
      child: this,
    );
  }
}
