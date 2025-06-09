import 'package:auto_route/auto_route.dart';

import '../../../../config/constants/routes/route_path.constant.dart';
import '../../../../core/common/presentation/routes/app_router.gr.dart';

class TodoRoute {
  static final route = AutoRoute(
    page: TodoWrapperRoute.page,
    path: RoutePath.todo,
    children: [AutoRoute(page: TodoPageRoute.page, initial: true)],
  );
}
