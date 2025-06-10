part of 'device_info.bloc.dart';

abstract class DeviceInfoEvent extends Equatable {
  const DeviceInfoEvent();

  @override
  List<Object?> get props => [];
}

class FetchDeviceInfoEvent extends DeviceInfoEvent {
  const FetchDeviceInfoEvent();

  @override
  List<Object?> get props => [];
}
