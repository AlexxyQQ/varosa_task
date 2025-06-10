import 'dart:developer';

import 'package:device_info_channel/device_info_channel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/common/data/models/error/app_error.model.dart';

part 'device_info.event.dart';
part 'device_info.state.dart';
part 'device_info.bloc.freezed.dart';

class DeviceInfoBloc extends Bloc<DeviceInfoEvent, DeviceInfoState> {
  DeviceInfoBloc() : super(DeviceInfoState.initial()) {
    on<FetchDeviceInfoEvent>(_onFetchDeviceInfo);
  }

  Future<void> _onFetchDeviceInfo(
    FetchDeviceInfoEvent event,
    Emitter<DeviceInfoState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));
      final deviceInfo = await DeviceInfoChannel.getDeviceInfo();
      log("deviceInfo: ${deviceInfo.toString()}");
      emit(state.copyWith(deviceInfo: deviceInfo, isLoading: false));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: AppErrorModel(message: e.toString()),
          deviceInfo: null,
        ),
      );
    }
  }
}
