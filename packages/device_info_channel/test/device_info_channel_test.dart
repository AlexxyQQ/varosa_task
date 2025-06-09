import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:device_info_channel/device_info_channel.dart';

void main() {
  group('DeviceInfo', () {
    test('should create DeviceInfo from JSON correctly', () {
      // Arrange
      final json = {
        'batteryLevel': 75,
        'deviceModel': 'Test Device',
        'isCharging': true,
        'systemTime': '2025-06-09T12:30:00Z',
      };

      // Act
      final deviceInfo = DeviceInfo.fromJson(json);

      // Assert
      expect(deviceInfo.batteryLevel, 75);
      expect(deviceInfo.deviceModel, 'Test Device');
      expect(deviceInfo.isCharging, true);
      expect(deviceInfo.systemTime, DateTime.parse('2025-06-09T12:30:00Z'));
    });

    test('should handle different battery levels', () {
      // Test low battery
      final lowBatteryJson = {
        'batteryLevel': 15,
        'deviceModel': 'Test Device',
        'isCharging': false,
        'systemTime': '2025-06-09T12:30:00Z',
      };

      final lowBatteryInfo = DeviceInfo.fromJson(lowBatteryJson);
      expect(lowBatteryInfo.batteryLevel, 15);
      expect(lowBatteryInfo.isCharging, false);

      // Test full battery
      final fullBatteryJson = {
        'batteryLevel': 100,
        'deviceModel': 'Test Device',
        'isCharging': true,
        'systemTime': '2025-06-09T12:30:00Z',
      };

      final fullBatteryInfo = DeviceInfo.fromJson(fullBatteryJson);
      expect(fullBatteryInfo.batteryLevel, 100);
      expect(fullBatteryInfo.isCharging, true);
    });

    test('should handle different device models', () {
      final androidJson = {
        'batteryLevel': 50,
        'deviceModel': 'Google Pixel 6',
        'isCharging': false,
        'systemTime': '2025-06-09T12:30:00Z',
      };

      final androidInfo = DeviceInfo.fromJson(androidJson);
      expect(androidInfo.deviceModel, 'Google Pixel 6');

      final iOSJson = {
        'batteryLevel': 80,
        'deviceModel': 'iPhone',
        'isCharging': true,
        'systemTime': '2025-06-09T12:30:00Z',
      };

      final iOSInfo = DeviceInfo.fromJson(iOSJson);
      expect(iOSInfo.deviceModel, 'iPhone');
    });
  });

  group('DeviceInfoChannel', () {
    const MethodChannel channel = MethodChannel('device_info_channel');

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    });

    test('should return device info when native call succeeds', () async {
      // Arrange
      final expectedResponse = {
        'batteryLevel': 88,
        'deviceModel': 'Pixel 6',
        'isCharging': true,
        'systemTime': '2025-06-09T12:30:00Z',
      };

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
            if (methodCall.method == 'getDeviceInfo') {
              return expectedResponse;
            }
            return null;
          });

      // Act
      final deviceInfo = await DeviceInfoChannel.getDeviceInfo();

      // Assert
      expect(deviceInfo.batteryLevel, 88);
      expect(deviceInfo.deviceModel, 'Pixel 6');
      expect(deviceInfo.isCharging, true);
      expect(deviceInfo.systemTime, DateTime.parse('2025-06-09T12:30:00Z'));
    });

    test('should throw exception when native call fails', () async {
      // Arrange
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
            if (methodCall.method == 'getDeviceInfo') {
              throw PlatformException(
                code: 'DEVICE_INFO_ERROR',
                message: 'Failed to get device info',
              );
            }
            return null;
          });

      // Act & Assert
      expect(
        () => DeviceInfoChannel.getDeviceInfo(),
        throwsA(isA<Exception>()),
      );
    });

    test('should handle different charging states', () async {
      // Test not charging
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
            if (methodCall.method == 'getDeviceInfo') {
              return {
                'batteryLevel': 45,
                'deviceModel': 'Test Device',
                'isCharging': false,
                'systemTime': '2025-06-09T12:30:00Z',
              };
            }
            return null;
          });

      final notChargingInfo = await DeviceInfoChannel.getDeviceInfo();
      expect(notChargingInfo.isCharging, false);

      // Test charging
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
            if (methodCall.method == 'getDeviceInfo') {
              return {
                'batteryLevel': 60,
                'deviceModel': 'Test Device',
                'isCharging': true,
                'systemTime': '2025-06-09T12:30:00Z',
              };
            }
            return null;
          });

      final chargingInfo = await DeviceInfoChannel.getDeviceInfo();
      expect(chargingInfo.isCharging, true);
    });

    test('should handle various time formats', () async {
      // Arrange
      final timeFormats = [
        '2025-06-09T12:30:00Z',
        '2025-12-25T23:59:59Z',
        '2025-01-01T00:00:00Z',
      ];

      for (final timeFormat in timeFormats) {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
              if (methodCall.method == 'getDeviceInfo') {
                return {
                  'batteryLevel': 50,
                  'deviceModel': 'Test Device',
                  'isCharging': false,
                  'systemTime': timeFormat,
                };
              }
              return null;
            });

        // Act
        final deviceInfo = await DeviceInfoChannel.getDeviceInfo();

        // Assert
        expect(deviceInfo.systemTime, DateTime.parse(timeFormat));
      }
    });
  });
}
