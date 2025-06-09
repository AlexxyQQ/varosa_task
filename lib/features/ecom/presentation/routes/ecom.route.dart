import 'package:auto_route/auto_route.dart';

import '../../../../config/constants/routes/route_path.constant.dart';
import '../../../../core/common/presentation/routes/app_router.gr.dart';

class EcomRoute {
  static final routes = AutoRoute(
    page: EcomWrapperRoute.page,
    path: RoutePath.ecom,
  );
}
