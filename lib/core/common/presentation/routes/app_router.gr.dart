// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:varosa_task/core/common/presentation/views/wrappers/bottom_navigation.wrapper.dart'
    as _i1;
import 'package:varosa_task/features/device_info/presentation/pages/device_info_page.dart'
    as _i2;
import 'package:varosa_task/features/dynamic_form/presentation/views/pages/form.page.dart'
    as _i4;
import 'package:varosa_task/features/dynamic_form/presentation/views/wrapper/form.wrapper.dart'
    as _i5;
import 'package:varosa_task/features/ecommerce/presentation/pages/product.page.dart'
    as _i6;
import 'package:varosa_task/features/ecommerce/presentation/views/wrapper/ecommerce.wrapper.dart'
    as _i3;
import 'package:varosa_task/features/slash/presentation/view/pages/splash.page.dart'
    as _i7;
import 'package:varosa_task/features/todo/presentation/view/pages/todo.page.dart'
    as _i8;
import 'package:varosa_task/features/todo/presentation/view/wrapper/todo.wrapper.dart'
    as _i9;

/// generated route for
/// [_i1.BottomNavWrapperPage]
class BottomNavigationWrapperRoute extends _i10.PageRouteInfo<void> {
  const BottomNavigationWrapperRoute({List<_i10.PageRouteInfo>? children})
    : super(BottomNavigationWrapperRoute.name, initialChildren: children);

  static const String name = 'BottomNavigationWrapperRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i1.BottomNavWrapperPage();
    },
  );
}

/// generated route for
/// [_i2.DeviceInfoPage]
class DeviceInfoRoute extends _i10.PageRouteInfo<void> {
  const DeviceInfoRoute({List<_i10.PageRouteInfo>? children})
    : super(DeviceInfoRoute.name, initialChildren: children);

  static const String name = 'DeviceInfoRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i10.WrappedRoute(child: const _i2.DeviceInfoPage());
    },
  );
}

/// generated route for
/// [_i3.ECommerceWrapper]
class ECommerceWrapperRoute extends _i10.PageRouteInfo<void> {
  const ECommerceWrapperRoute({List<_i10.PageRouteInfo>? children})
    : super(ECommerceWrapperRoute.name, initialChildren: children);

  static const String name = 'ECommerceWrapperRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i10.WrappedRoute(child: const _i3.ECommerceWrapper());
    },
  );
}

/// generated route for
/// [_i4.FormPage]
class FormPageRoute extends _i10.PageRouteInfo<void> {
  const FormPageRoute({List<_i10.PageRouteInfo>? children})
    : super(FormPageRoute.name, initialChildren: children);

  static const String name = 'FormPageRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i4.FormPage();
    },
  );
}

/// generated route for
/// [_i5.FormWrapper]
class FormWrapperRoute extends _i10.PageRouteInfo<void> {
  const FormWrapperRoute({List<_i10.PageRouteInfo>? children})
    : super(FormWrapperRoute.name, initialChildren: children);

  static const String name = 'FormWrapperRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i10.WrappedRoute(child: const _i5.FormWrapper());
    },
  );
}

/// generated route for
/// [_i6.ProductPage]
class ProductPageRoute extends _i10.PageRouteInfo<void> {
  const ProductPageRoute({List<_i10.PageRouteInfo>? children})
    : super(ProductPageRoute.name, initialChildren: children);

  static const String name = 'ProductPageRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i6.ProductPage();
    },
  );
}

/// generated route for
/// [_i7.SplashPage]
class SplashRoute extends _i10.PageRouteInfo<void> {
  const SplashRoute({List<_i10.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i7.SplashPage();
    },
  );
}

/// generated route for
/// [_i8.TodoPage]
class TodoPageRoute extends _i10.PageRouteInfo<void> {
  const TodoPageRoute({List<_i10.PageRouteInfo>? children})
    : super(TodoPageRoute.name, initialChildren: children);

  static const String name = 'TodoPageRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i8.TodoPage();
    },
  );
}

/// generated route for
/// [_i9.TodoWrapper]
class TodoWrapperRoute extends _i10.PageRouteInfo<void> {
  const TodoWrapperRoute({List<_i10.PageRouteInfo>? children})
    : super(TodoWrapperRoute.name, initialChildren: children);

  static const String name = 'TodoWrapperRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i10.WrappedRoute(child: const _i9.TodoWrapper());
    },
  );
}
