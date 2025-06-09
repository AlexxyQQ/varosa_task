// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:varosa_task/features/slash/presentation/view/pages/splash.page.dart'
    as _i2;
import 'package:varosa_task/features/todo/presentation/view/pages/item_detail.page.dart'
    as _i1;
import 'package:varosa_task/features/todo/presentation/view/pages/todo.page.dart'
    as _i3;
import 'package:varosa_task/features/todo/presentation/view/wrapper/todo.wrapper.dart'
    as _i4;

/// generated route for
/// [_i1.ItemDetailPage]
class ItemDetailPageRoute extends _i5.PageRouteInfo<void> {
  const ItemDetailPageRoute({List<_i5.PageRouteInfo>? children})
    : super(ItemDetailPageRoute.name, initialChildren: children);

  static const String name = 'ItemDetailPageRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.ItemDetailPage();
    },
  );
}

/// generated route for
/// [_i2.SplashPage]
class SplashRoute extends _i5.PageRouteInfo<void> {
  const SplashRoute({List<_i5.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.SplashPage();
    },
  );
}

/// generated route for
/// [_i3.TodoPage]
class TodoPageRoute extends _i5.PageRouteInfo<void> {
  const TodoPageRoute({List<_i5.PageRouteInfo>? children})
    : super(TodoPageRoute.name, initialChildren: children);

  static const String name = 'TodoPageRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.TodoPage();
    },
  );
}

/// generated route for
/// [_i4.TodoWrapper]
class TodoWrapperRoute extends _i5.PageRouteInfo<void> {
  const TodoWrapperRoute({List<_i5.PageRouteInfo>? children})
    : super(TodoWrapperRoute.name, initialChildren: children);

  static const String name = 'TodoWrapperRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return _i5.WrappedRoute(child: const _i4.TodoWrapper());
    },
  );
}
