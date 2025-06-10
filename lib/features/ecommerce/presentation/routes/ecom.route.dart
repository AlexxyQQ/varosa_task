import 'package:auto_route/auto_route.dart';

import '../../../../config/constants/routes/route_path.constant.dart';
import '../../../../core/common/presentation/routes/app_router.gr.dart';

class ECommerceRoute {
  static final routes = AutoRoute(
    page: ECommerceWrapperRoute.page,
    path: RoutePath.eCommerce,
    children: [
      AutoRoute(page: ProductPageRoute.page, initial: true),
      AutoRoute(
        page: ProductDetailPageRoute.page,
        path: RoutePath.productDetail,
      ),
    ],
  );
}
