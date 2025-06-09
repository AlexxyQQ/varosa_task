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

  factory DeviceInfo.fromJson(Map<String, dynamic> json) {
    return DeviceInfo(
      batteryLevel: json['batteryLevel'] as int,
      deviceModel: json['deviceModel'] as String,
      isCharging: json['isCharging'] as bool,
      systemTime: DateTime.parse(json['systemTime'] as String),
    );
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
