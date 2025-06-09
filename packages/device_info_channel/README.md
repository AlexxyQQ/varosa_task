<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Device Info Channel

A Flutter package that provides device information using MethodChannel to communicate with native Android and iOS platforms.

## Features

- **Battery Level**: Get current battery percentage (0-100)
- **Device Model**: Retrieve device model information
- **Charging Status**: Check if device is currently charging
- **System Time**: Get current system time in ISO format
- **Clean UI Widget**: Ready-to-use widget for displaying device information
- **Type-safe API**: Strongly typed Dart classes for device information

## Platform Support

| Platform | Support     |
| -------- | ----------- |
| Android  | ✅ API 16+  |
| iOS      | ✅ iOS 9.0+ |
| Web      | ❌          |
| Desktop  | ❌          |

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  device_info_channel:
    path: packages/device_info_channel # For local development
```

## Usage

### Basic Usage

```dart
import 'package:device_info_channel/device_info_channel.dart';

// Fetch device information
try {
  final deviceInfo = await DeviceInfoChannel.getDeviceInfo();

  print('Battery Level: ${deviceInfo.batteryLevel}%');
  print('Device Model: ${deviceInfo.deviceModel}');
  print('Is Charging: ${deviceInfo.isCharging}');
  print('System Time: ${deviceInfo.systemTime}');
} catch (e) {
  print('Error: $e');
}
```

### Using the Pre-built Widget

```dart
import 'package:device_info_channel/device_info_channel.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DeviceInfoWidget(), // Ready-to-use widget
    );
  }
}
```

### Custom Implementation

```dart
import 'package:device_info_channel/device_info_channel.dart';
import 'package:flutter/material.dart';

class CustomDeviceInfoPage extends StatefulWidget {
  @override
  _CustomDeviceInfoPageState createState() => _CustomDeviceInfoPageState();
}

class _CustomDeviceInfoPageState extends State<CustomDeviceInfoPage> {
  DeviceInfo? _deviceInfo;
  bool _isLoading = false;

  Future<void> _fetchDeviceInfo() async {
    setState(() => _isLoading = true);

    try {
      final info = await DeviceInfoChannel.getDeviceInfo();
      setState(() => _deviceInfo = info);
    } catch (e) {
      // Handle error
      print('Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Device Info')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _isLoading ? null : _fetchDeviceInfo,
            child: Text('Fetch Device Info'),
          ),
          if (_deviceInfo != null) ...[
            Text('Battery: ${_deviceInfo!.batteryLevel}%'),
            Text('Model: ${_deviceInfo!.deviceModel}'),
            Text('Charging: ${_deviceInfo!.isCharging}'),
            Text('Time: ${_deviceInfo!.systemTime}'),
          ],
        ],
      ),
    );
  }
}
```

## API Reference

### DeviceInfoChannel

Main class for communicating with native platforms.

#### Methods

##### `getDeviceInfo()`

Returns device information from the native platform.

**Returns:** `Future<DeviceInfo>`

**Throws:** `Exception` if unable to fetch device information

### DeviceInfo

Model class representing device information.

#### Properties

- `batteryLevel` (int): Battery level percentage (0-100)
- `deviceModel` (String): Device model name
- `isCharging` (bool): Whether device is currently charging
- `systemTime` (DateTime): Current system time

#### Factory Methods

- `DeviceInfo.fromJson(Map<String, dynamic> json)`: Creates instance from JSON

### DeviceInfoWidget

Pre-built widget that displays device information with a clean UI.

#### Features

- Material Design UI
- Loading states
- Error handling
- Refresh button
- Responsive layout

## Native Platform Details

### Android Implementation

The Android implementation uses:

- `BatteryManager` for battery information
- `Build` class for device model
- `Intent.ACTION_BATTERY_CHANGED` for charging status
- `SimpleDateFormat` for ISO time formatting

### iOS Implementation

The iOS implementation uses:

- `UIDevice.current` for device information
- `batteryLevel` and `batteryState` for battery info
- `ISO8601DateFormatter` for time formatting

## JSON Response Format

The native platforms return data in this JSON format:

```json
{
  "batteryLevel": 88,
  "deviceModel": "Pixel 6",
  "isCharging": true,
  "systemTime": "2025-06-09T12:30:00Z"
}
```

## Error Handling

The package provides comprehensive error handling:

```dart
try {
  final deviceInfo = await DeviceInfoChannel.getDeviceInfo();
  // Use device info
} catch (e) {
  if (e.toString().contains('DEVICE_INFO_ERROR')) {
    // Handle platform-specific error
  } else {
    // Handle other errors (parsing, etc.)
  }
}
```

## Examples

Check out the example app in the main project's `lib/features/device_info/` folder for a complete implementation.

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License.
