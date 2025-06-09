// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:varosa_task/core/common/presentation/views/wrappers/bottom_navigation.wrapper.dart'
    as _i1;
import 'package:varosa_task/features/ecom/presentation/views/wrapper/ecom.wrapper.dart'
    as _i2;
import 'package:varosa_task/features/form_generator/presentation/wrapper/form.wrapper.dart'
    as _i3;
import 'package:varosa_task/features/slash/presentation/view/pages/splash.page.dart'
    as _i4;
import 'package:varosa_task/features/todo/presentation/view/pages/todo.page.dart'
    as _i5;
import 'package:varosa_task/features/todo/presentation/view/wrapper/todo.wrapper.dart'
    as _i6;

/// generated route for
/// [_i1.BottomNavWrapperPage]
class BottomNavigationWrapperRoute extends _i7.PageRouteInfo<void> {
  const BottomNavigationWrapperRoute({List<_i7.PageRouteInfo>? children})
    : super(BottomNavigationWrapperRoute.name, initialChildren: children);

  static const String name = 'BottomNavigationWrapperRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.BottomNavWrapperPage();
    },
  );
}

/// generated route for
/// [_i2.EcomWrapper]
class EcomWrapperRoute extends _i7.PageRouteInfo<void> {
  const EcomWrapperRoute({List<_i7.PageRouteInfo>? children})
    : super(EcomWrapperRoute.name, initialChildren: children);

  static const String name = 'EcomWrapperRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return _i7.WrappedRoute(child: const _i2.EcomWrapper());
    },
  );
}

/// generated route for
/// [_i3.FormWrapper]
class FormWrapperRoute extends _i7.PageRouteInfo<void> {
  const FormWrapperRoute({List<_i7.PageRouteInfo>? children})
    : super(FormWrapperRoute.name, initialChildren: children);

  static const String name = 'FormWrapperRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.FormWrapper();
    },
  );
}

/// generated route for
/// [_i4.SplashPage]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute({List<_i7.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.SplashPage();
    },
  );
}

/// generated route for
/// [_i5.TodoPage]
class TodoPageRoute extends _i7.PageRouteInfo<void> {
  const TodoPageRoute({List<_i7.PageRouteInfo>? children})
    : super(TodoPageRoute.name, initialChildren: children);

  static const String name = 'TodoPageRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.TodoPage();
    },
  );
}

/// generated route for
/// [_i6.TodoWrapper]
class TodoWrapperRoute extends _i7.PageRouteInfo<void> {
  const TodoWrapperRoute({List<_i7.PageRouteInfo>? children})
    : super(TodoWrapperRoute.name, initialChildren: children);

  static const String name = 'TodoWrapperRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return _i7.WrappedRoute(child: const _i6.TodoWrapper());
    },
  );
}
