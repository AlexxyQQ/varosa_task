import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppRouteObserver extends AutoRouteObserver {
  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    log(
      "Tab change ${previousRoute.path} ---> ${route.path}",
      name: "AutoRoute Observer",
    );
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    log(
      "Tab initialized ${previousRoute?.path} ---> ${route.path}",
      name: "AutoRoute Observer",
    );
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    log(
      "Did pop ${previousRoute?.data?.path} ---> ${route.data?.path}",
      name: "AutoRoute Observer",
    );
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    log(
      "Did push ${previousRoute?.data?.path} ---> ${route.data?.path}",
      name: "AutoRoute Observer",
    );
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    log("Did remove", name: "AutoRoute Observer");
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    log(
      "Did replace ${newRoute?.settings.arguments}",
      name: "AutoRoute Observer",
    );
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {}

  @override
  void didStopUserGesture() {}

  @override
  void subscribe(AutoRouteAware routeAware, RouteData route) {
    log("Subscribed", name: "AutoRoute Observer");
  }

  @override
  void unsubscribe(AutoRouteAware routeAware) {
    log("UnSubscribed", name: "AutoRoute Observer");
  }
}
