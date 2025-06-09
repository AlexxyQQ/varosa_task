import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../presentation/routes/app_router.dart';

typedef RouteFailure = void Function(NavigationFailure)?;

class NavigationService {
  final AppRouter _appRouter;
  static NavigationService? _instance;

  const NavigationService._(this._appRouter);

  factory NavigationService._internal(AppRouter appRouter) =>
      NavigationService._(appRouter);

  factory NavigationService(AppRouter appRouter) {
    _instance ??= NavigationService._internal(appRouter);
    return _instance!;
  }
  Future<void> push(PageRouteInfo route, {OnNavigationFailure? onFailure}) {
    return _appRouter.push(route, onFailure: onFailure);
  }

  Future<void> pushNamed(String routeName, {Object? arguments}) {
    return _appRouter.pushNamed(routeName);
  }

  Future<void> replace(PageRouteInfo route, {OnNavigationFailure? onFailure}) {
    return _appRouter.replace(route, onFailure: onFailure);
  }

  Future<void> replaceNamed(
    String routeName, {
    OnNavigationFailure? onFailure,
  }) {
    return _appRouter.replaceNamed(routeName, onFailure: onFailure);
  }

  void popForced<T extends Object?>([T? result]) {
    _appRouter.popForced(result);
  }

  Future<bool> maybePop() {
    return _appRouter.maybePop();
  }

  Future<bool> maybePopTop() {
    return _appRouter.maybePopTop();
  }

  Future<void> replaceAll(
    List<PageRouteInfo<dynamic>> routes, {
    RouteFailure onFailure,
    bool updateExistingRoutes = true,
  }) {
    return _appRouter.replaceAll(
      routes,
      onFailure: onFailure,
      updateExistingRoutes: updateExistingRoutes,
    );
  }

  void popUntil(RoutePredicate predicate, {bool scoped = true}) {
    return _appRouter.popUntil(predicate, scoped: scoped);
  }

  // Future<void> replaceAll(List<PageRouteInfo> routes) {
  //   return _appRouter.replaceAll(routes);
  // }

  // void popUntil(RoutePredicate predicate) {
  //   _appRouter.popUntil(predicate);
  // }

  void popUntilRoot() {
    _appRouter.popUntilRoot();
  }

  bool canPop() {
    return _appRouter.canPop();
  }
}
