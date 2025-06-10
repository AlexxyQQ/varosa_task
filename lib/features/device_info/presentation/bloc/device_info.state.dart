part of 'device_info.bloc.dart';

@freezed
abstract class DeviceInfoState with _$DeviceInfoState {
  const DeviceInfoState._();

  const factory DeviceInfoState({
    @Default(false) bool isLoading,
    AppErrorModel? error,
    DeviceInfo? deviceInfo,
  }) = _DeviceInfoState;

  factory DeviceInfoState.initial() => const DeviceInfoState();
}
