import 'package:auto_route/auto_route.dart';
import '../../../../config/constants/routes/route_path.constant.dart';
import '../../../../features/todo/presentation/routes/todo.route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, path: RoutePath.splash),
    TodoRoute.route,
  ];
}
