// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:varosa_task/core/common/presentation/views/wrappers/bottom_navigation.wrapper.dart'
    as _i1;
import 'package:varosa_task/features/device_info/presentation/pages/device_info_page.dart'
    as _i2;
import 'package:varosa_task/features/dynamic_form/presentation/views/pages/form.page.dart'
    as _i4;
import 'package:varosa_task/features/dynamic_form/presentation/views/wrapper/form.wrapper.dart'
    as _i5;
import 'package:varosa_task/features/ecom/presentation/views/wrapper/ecom.wrapper.dart'
    as _i3;
import 'package:varosa_task/features/slash/presentation/view/pages/splash.page.dart'
    as _i6;
import 'package:varosa_task/features/todo/presentation/view/pages/todo.page.dart'
    as _i7;
import 'package:varosa_task/features/todo/presentation/view/wrapper/todo.wrapper.dart'
    as _i8;

/// generated route for
/// [_i1.BottomNavWrapperPage]
class BottomNavigationWrapperRoute extends _i9.PageRouteInfo<void> {
  const BottomNavigationWrapperRoute({List<_i9.PageRouteInfo>? children})
    : super(BottomNavigationWrapperRoute.name, initialChildren: children);

  static const String name = 'BottomNavigationWrapperRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i1.BottomNavWrapperPage();
    },
  );
}

/// generated route for
/// [_i2.DeviceInfoPage]
class DeviceInfoRoute extends _i9.PageRouteInfo<void> {
  const DeviceInfoRoute({List<_i9.PageRouteInfo>? children})
    : super(DeviceInfoRoute.name, initialChildren: children);

  static const String name = 'DeviceInfoRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return _i9.WrappedRoute(child: const _i2.DeviceInfoPage());
    },
  );
}

/// generated route for
/// [_i3.EcomWrapper]
class EcomWrapperRoute extends _i9.PageRouteInfo<void> {
  const EcomWrapperRoute({List<_i9.PageRouteInfo>? children})
    : super(EcomWrapperRoute.name, initialChildren: children);

  static const String name = 'EcomWrapperRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return _i9.WrappedRoute(child: const _i3.EcomWrapper());
    },
  );
}

/// generated route for
/// [_i4.FormPage]
class FormPageRoute extends _i9.PageRouteInfo<void> {
  const FormPageRoute({List<_i9.PageRouteInfo>? children})
    : super(FormPageRoute.name, initialChildren: children);

  static const String name = 'FormPageRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i4.FormPage();
    },
  );
}

/// generated route for
/// [_i5.FormWrapper]
class FormWrapperRoute extends _i9.PageRouteInfo<void> {
  const FormWrapperRoute({List<_i9.PageRouteInfo>? children})
    : super(FormWrapperRoute.name, initialChildren: children);

  static const String name = 'FormWrapperRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return _i9.WrappedRoute(child: const _i5.FormWrapper());
    },
  );
}

/// generated route for
/// [_i6.SplashPage]
class SplashRoute extends _i9.PageRouteInfo<void> {
  const SplashRoute({List<_i9.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i6.SplashPage();
    },
  );
}

/// generated route for
/// [_i7.TodoPage]
class TodoPageRoute extends _i9.PageRouteInfo<void> {
  const TodoPageRoute({List<_i9.PageRouteInfo>? children})
    : super(TodoPageRoute.name, initialChildren: children);

  static const String name = 'TodoPageRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i7.TodoPage();
    },
  );
}

/// generated route for
/// [_i8.TodoWrapper]
class TodoWrapperRoute extends _i9.PageRouteInfo<void> {
  const TodoWrapperRoute({List<_i9.PageRouteInfo>? children})
    : super(TodoWrapperRoute.name, initialChildren: children);

  static const String name = 'TodoWrapperRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return _i9.WrappedRoute(child: const _i8.TodoWrapper());
    },
  );
}
