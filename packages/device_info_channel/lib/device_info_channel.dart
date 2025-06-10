// ignore_for_file: public_member_api_docs, sort_constructors_first
library device_info_channel;

import 'dart:convert';

import 'package:flutter/services.dart';

export 'device_info_widget.dart';

/// Model class to represent device information
class DeviceInfo {
  final int batteryLevel;
  final String deviceModel;
  final bool isCharging;
  final DateTime systemTime;

  DeviceInfo({
    required this.batteryLevel,
    required this.deviceModel,
    required this.isCharging,
    required this.systemTime,
  });

  // factory DeviceInfo.fromJson(Map<String, dynamic> json) {
  //   return DeviceInfo(
  //     batteryLevel: json['batteryLevel'] as int,
  //     deviceModel: json['deviceModel'] as String,
  //     isCharging: json['isCharging'] as bool,
  //     systemTime: DateTime.parse(json['systemTime'] as String),
  //   );
  // }

  DeviceInfo copyWith({
    int? batteryLevel,
    String? deviceModel,
    bool? isCharging,
    DateTime? systemTime,
  }) {
    return DeviceInfo(
      batteryLevel: batteryLevel ?? this.batteryLevel,
      deviceModel: deviceModel ?? this.deviceModel,
      isCharging: isCharging ?? this.isCharging,
      systemTime: systemTime ?? this.systemTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'batteryLevel': batteryLevel,
      'deviceModel': deviceModel,
      'isCharging': isCharging,
      'systemTime': systemTime.millisecondsSinceEpoch,
    };
  }

  factory DeviceInfo.fromMap(Map<String, dynamic> map) {
    return DeviceInfo(
      batteryLevel: map['batteryLevel'] as int,
      deviceModel: map['deviceModel'] as String,
      isCharging: map['isCharging'] as bool,
      systemTime: DateTime.fromMillisecondsSinceEpoch(map['systemTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceInfo.fromJson(String source) =>
      DeviceInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DeviceInfo(batteryLevel: $batteryLevel, deviceModel: $deviceModel, isCharging: $isCharging, systemTime: $systemTime)';
  }

  @override
  bool operator ==(covariant DeviceInfo other) {
    if (identical(this, other)) return true;

    return other.batteryLevel == batteryLevel &&
        other.deviceModel == deviceModel &&
        other.isCharging == isCharging &&
        other.systemTime == systemTime;
  }

  @override
  int get hashCode {
    return batteryLevel.hashCode ^
        deviceModel.hashCode ^
        isCharging.hashCode ^
        systemTime.hashCode;
  }
}

/// Main class for device information channel communication
class DeviceInfoChannel {
  static const MethodChannel _channel = MethodChannel('device_info_channel');

  /// Fetches device information from native platform
  static Future<DeviceInfo> getDeviceInfo() async {
    try {
      final Map<dynamic, dynamic> result = await _channel.invokeMethod(
        'getDeviceInfo',
      );
      final Map<String, dynamic> jsonMap = Map<String, dynamic>.from(result);
      return DeviceInfo.fromJson(jsonMap);
    } on PlatformException catch (e) {
      throw Exception('Failed to get device info: ${e.message}');
    }
  }
}
