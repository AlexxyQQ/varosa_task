import 'package:auto_route/auto_route.dart';

import '../../../../config/constants/routes/route_path.constant.dart';
import '../../../../core/common/presentation/routes/app_router.gr.dart';

class FormRoute {
  static final route = AutoRoute(
    page: FormWrapperRoute.page,
    path: RoutePath.form,
    // children: [AutoRoute(page: FormPageRoute.page, initial: true)],
  );
}
