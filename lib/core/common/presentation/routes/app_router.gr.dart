// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:varosa_task/features/slash/presentation/view/pages/splash.page.dart'
    as _i1;
import 'package:varosa_task/features/todo/presentation/view/pages/todo.page.dart'
    as _i2;
import 'package:varosa_task/features/todo/presentation/view/wrapper/todo.wrapper.dart'
    as _i3;

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i4.PageRouteInfo<void> {
  const SplashRoute({List<_i4.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.SplashPage();
    },
  );
}

/// generated route for
/// [_i2.TodoPage]
class TodoPageRoute extends _i4.PageRouteInfo<void> {
  const TodoPageRoute({List<_i4.PageRouteInfo>? children})
    : super(TodoPageRoute.name, initialChildren: children);

  static const String name = 'TodoPageRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.TodoPage();
    },
  );
}

/// generated route for
/// [_i3.TodoWrapper]
class TodoWrapperRoute extends _i4.PageRouteInfo<void> {
  const TodoWrapperRoute({List<_i4.PageRouteInfo>? children})
    : super(TodoWrapperRoute.name, initialChildren: children);

  static const String name = 'TodoWrapperRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return _i4.WrappedRoute(child: const _i3.TodoWrapper());
    },
  );
}
