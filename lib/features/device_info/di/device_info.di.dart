import '../../../core/di/main.di.dart';
import '../presentation/bloc/device_info.bloc.dart';

class DeviceInfoDI {
  static void register() {
    sl.registerFactory(() => DeviceInfoBloc());
  }
}
