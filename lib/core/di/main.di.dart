import 'package:get_it/get_it.dart';

import '../../config/constants/flavour/app_flavour.constant.dart';
import '../../config/observers/app_route.oserver.dart';
import '../../config/observers/bloc_observer.dart';
import '../../features/device_info/di/device_info.di.dart';
import '../../features/dynamic_form/di/dynamic_form.di.dart';
import '../../features/ecommerce/di/ecommerce.di.dart';
import '../../features/todo/di/country.di.dart';
import '../common/domain/services/api/dio.service.dart';
import '../common/domain/services/navigation/navigation.service.dart';
import '../common/domain/services/storage/secure_storage.service.dart';
import '../common/domain/services/storage/shared_preference.service.dart';
import '../common/presentation/helpers/date_time.helper.dart';
import '../common/presentation/routes/app_router.dart';

/// Service locator instance for dependency injection
final sl = GetIt.instance;

/// Main dependency injection class that registers all dependencies for the application
class MainDI {
  /// Registers all dependencies required for the application
  ///
  /// [appFlavor] - The application flavor/environment configuration
  Future<void> register({required AppFlavor appFlavor}) async {
    // Register app flavor configuration
    sl.registerSingleton<AppFlavor>(appFlavor);
    // ==== App Router ====
    sl.registerLazySingleton(() => AppRouter());
    // ==== Observers ====
    sl.registerFactory(() => AppRouteObserver());
    sl.registerSingleton<AppBlocObserver>(AppBlocObserver());

    // ==== Helpers ====
    sl.registerLazySingleton(() => DateTimeHelper());

    // ==== Services ====
    sl.registerSingleton<DioService>(DioService());
    sl.registerCachedFactory(() => NavigationService(sl<AppRouter>()));
    sl.registerSingleton<SecureStorageService>(const SecureStorageService());
    final sharedPreferencesService = await SharedPreferencesService.create();
    sl.registerSingleton<SharedPreferencesService>(sharedPreferencesService);

    // ==== Blocs ====

    // ==== Features ====
    ItemDI.register();
    DynamicFormDi.register();
    DeviceInfoDI.register();
    ECommerceDI.register();
  }
}
