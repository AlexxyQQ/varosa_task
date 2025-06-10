// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;
import 'package:varosa_task/core/common/presentation/views/wrappers/bottom_navigation.wrapper.dart'
    as _i1;
import 'package:varosa_task/features/device_info/presentation/pages/device_info_page.dart'
    as _i2;
import 'package:varosa_task/features/dynamic_form/presentation/views/pages/form.page.dart'
    as _i4;
import 'package:varosa_task/features/dynamic_form/presentation/views/wrapper/form.wrapper.dart'
    as _i5;
import 'package:varosa_task/features/ecommerce/presentation/pages/product.page.dart'
    as _i7;
import 'package:varosa_task/features/ecommerce/presentation/pages/product_detail.page.dart'
    as _i6;
import 'package:varosa_task/features/ecommerce/presentation/views/wrapper/ecommerce.wrapper.dart'
    as _i3;
import 'package:varosa_task/features/slash/presentation/view/pages/splash.page.dart'
    as _i8;
import 'package:varosa_task/features/todo/presentation/view/pages/todo.page.dart'
    as _i9;
import 'package:varosa_task/features/todo/presentation/view/wrapper/todo.wrapper.dart'
    as _i10;

/// generated route for
/// [_i1.BottomNavWrapperPage]
class BottomNavigationWrapperRoute extends _i11.PageRouteInfo<void> {
  const BottomNavigationWrapperRoute({List<_i11.PageRouteInfo>? children})
    : super(BottomNavigationWrapperRoute.name, initialChildren: children);

  static const String name = 'BottomNavigationWrapperRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i1.BottomNavWrapperPage();
    },
  );
}

/// generated route for
/// [_i2.DeviceInfoPage]
class DeviceInfoRoute extends _i11.PageRouteInfo<void> {
  const DeviceInfoRoute({List<_i11.PageRouteInfo>? children})
    : super(DeviceInfoRoute.name, initialChildren: children);

  static const String name = 'DeviceInfoRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.WrappedRoute(child: const _i2.DeviceInfoPage());
    },
  );
}

/// generated route for
/// [_i3.ECommerceWrapper]
class ECommerceWrapperRoute extends _i11.PageRouteInfo<void> {
  const ECommerceWrapperRoute({List<_i11.PageRouteInfo>? children})
    : super(ECommerceWrapperRoute.name, initialChildren: children);

  static const String name = 'ECommerceWrapperRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.WrappedRoute(child: const _i3.ECommerceWrapper());
    },
  );
}

/// generated route for
/// [_i4.FormPage]
class FormPageRoute extends _i11.PageRouteInfo<void> {
  const FormPageRoute({List<_i11.PageRouteInfo>? children})
    : super(FormPageRoute.name, initialChildren: children);

  static const String name = 'FormPageRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i4.FormPage();
    },
  );
}

/// generated route for
/// [_i5.FormWrapper]
class FormWrapperRoute extends _i11.PageRouteInfo<void> {
  const FormWrapperRoute({List<_i11.PageRouteInfo>? children})
    : super(FormWrapperRoute.name, initialChildren: children);

  static const String name = 'FormWrapperRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.WrappedRoute(child: const _i5.FormWrapper());
    },
  );
}

/// generated route for
/// [_i6.ProductDetailPage]
class ProductDetailPageRoute
    extends _i11.PageRouteInfo<ProductDetailPageRouteArgs> {
  ProductDetailPageRoute({
    _i12.Key? key,
    required int productId,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         ProductDetailPageRoute.name,
         args: ProductDetailPageRouteArgs(key: key, productId: productId),
         rawPathParams: {'id': productId},
         initialChildren: children,
       );

  static const String name = 'ProductDetailPageRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ProductDetailPageRouteArgs>(
        orElse: () =>
            ProductDetailPageRouteArgs(productId: pathParams.getInt('id')),
      );
      return _i11.WrappedRoute(
        child: _i6.ProductDetailPage(key: args.key, productId: args.productId),
      );
    },
  );
}

class ProductDetailPageRouteArgs {
  const ProductDetailPageRouteArgs({this.key, required this.productId});

  final _i12.Key? key;

  final int productId;

  @override
  String toString() {
    return 'ProductDetailPageRouteArgs{key: $key, productId: $productId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProductDetailPageRouteArgs) return false;
    return key == other.key && productId == other.productId;
  }

  @override
  int get hashCode => key.hashCode ^ productId.hashCode;
}

/// generated route for
/// [_i7.ProductPage]
class ProductPageRoute extends _i11.PageRouteInfo<void> {
  const ProductPageRoute({List<_i11.PageRouteInfo>? children})
    : super(ProductPageRoute.name, initialChildren: children);

  static const String name = 'ProductPageRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i7.ProductPage();
    },
  );
}

/// generated route for
/// [_i8.SplashPage]
class SplashRoute extends _i11.PageRouteInfo<void> {
  const SplashRoute({List<_i11.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i8.SplashPage();
    },
  );
}

/// generated route for
/// [_i9.TodoPage]
class TodoPageRoute extends _i11.PageRouteInfo<void> {
  const TodoPageRoute({List<_i11.PageRouteInfo>? children})
    : super(TodoPageRoute.name, initialChildren: children);

  static const String name = 'TodoPageRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i9.TodoPage();
    },
  );
}

/// generated route for
/// [_i10.TodoWrapper]
class TodoWrapperRoute extends _i11.PageRouteInfo<void> {
  const TodoWrapperRoute({List<_i11.PageRouteInfo>? children})
    : super(TodoWrapperRoute.name, initialChildren: children);

  static const String name = 'TodoWrapperRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.WrappedRoute(child: const _i10.TodoWrapper());
    },
  );
}
