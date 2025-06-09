import 'package:auto_route/auto_route.dart';

import '../../../../config/constants/routes/route_path.constant.dart';
import '../../../../features/dynamic_form/presentation/routes/form.route.dart';
import '../../../../features/ecom/presentation/routes/ecom.route.dart';
import '../../../../features/todo/presentation/routes/todo.route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, path: RoutePath.splash),
    AutoRoute(
      page: BottomNavigationWrapperRoute.page,
      path: RoutePath.bottomNavigation,
      children: [
        TodoRoute.route,
        FormRoute.route,
        EcomRoute.routes,
        AutoRoute(page: DeviceInfoRoute.page, path: "device-info"),
      ],
    ),
  ];
}
