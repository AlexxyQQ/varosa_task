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

A comprehensive Flutter plugin that provides device information using MethodChannel to communicate with native Android and iOS platforms. This plugin demonstrates cross-platform native integration and provides essential device metrics for Flutter applications.

## How It Works

This plugin implements a **MethodChannel** bridge between Flutter (Dart) and native platform code (Android Kotlin/iOS Swift). It follows the official Flutter plugin architecture pattern:

1. **Dart Layer**: Exposes a clean API via `DeviceInfoChannel` class
2. **Platform Channels**: Uses MethodChannel for bidirectional communication
3. **Native Implementations**: Platform-specific code accessing system APIs
4. **Type Safety**: Strongly typed data models for reliable information transfer

### Architecture Overview

```
┌─────────────────┐    MethodChannel     ┌─────────────────┐
│   Flutter App   │ ◄─────────────────► │ Native Platform │
│   (Dart Code)   │   "device_info_     │ (Kotlin/Swift)  │
│                 │    _channel"        │                 │
└─────────────────┘                     └─────────────────┘
```

## Features

- **Battery Level**: Real-time battery percentage (0-100)
- **Device Model**: Manufacturer and model information
- **Charging Status**: Current charging state detection
- **System Time**: ISO 8601 formatted timestamps
- **Clean UI Widget**: Pre-built Material Design interface
- **Type-safe API**: Strongly typed Dart classes with error handling
- **Cross-platform**: Unified API for both Android and iOS

## Platform Support

| Platform | Support | Minimum Version |
| -------- | ------- | --------------- |
| Android  | ✅ Full | API 16+ (4.1)   |
| iOS      | ✅ Full | iOS 9.0+        |
| Web      | ❌ N/A  | -               |
| Desktop  | ❌ N/A  | -               |

## Technical Implementation

### Android Implementation

The Android plugin (`DeviceInfoChannelPlugin.kt`) utilizes:

- **BatteryManager**: Modern API for battery information
  - `BATTERY_PROPERTY_CAPACITY` for percentage
  - `ACTION_BATTERY_CHANGED` intent for charging status
- **Build Class**: System information from `android.os.Build`
  - `Build.MANUFACTURER` and `Build.MODEL` for device identification
- **Context Services**: System service access for hardware data
- **SimpleDateFormat**: UTC timestamp generation in ISO 8601 format

**Key Android APIs Used:**

- `Context.getSystemService(Context.BATTERY_SERVICE)`
- `BatteryManager.getIntProperty()`
- `Intent.ACTION_BATTERY_CHANGED`
- `Build.MANUFACTURER` and `Build.MODEL`

### iOS Implementation

The iOS plugin (`DeviceInfoChannelPlugin.swift`) leverages:

- **UIDevice**: Primary device information source
  - `batteryLevel` property for charge percentage
  - `batteryState` enum for charging detection
  - `model` property for device type
- **ISO8601DateFormatter**: Standardized timestamp formatting
- **Battery Monitoring**: Enabled for accurate readings

**Key iOS APIs Used:**

- `UIDevice.current.isBatteryMonitoringEnabled`
- `UIDevice.current.batteryLevel`
- `UIDevice.current.batteryState`
- `UIDevice.current.model`
- `ISO8601DateFormatter`

### Flutter Integration

The Dart implementation follows Flutter's plugin conventions:

- **MethodChannel**: Uses channel name `"device_info_channel"`
- **Platform Messages**: Async communication with `invokeMethod`
- **Error Handling**: Platform exceptions converted to Dart exceptions
- **Data Models**: Type-safe `DeviceInfo` class with JSON serialization

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  device_info_channel:
    path: packages/device_info_channel # Local development
```

Then run:

```bash
flutter pub get
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
      home: DeviceInfoWidget(), // Ready-to-use Material Design widget
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
  String? _errorMessage;

  Future<void> _fetchDeviceInfo() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final info = await DeviceInfoChannel.getDeviceInfo();
      setState(() => _deviceInfo = info);
    } catch (e) {
      setState(() => _errorMessage = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Device Information')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _fetchDeviceInfo,
              icon: _isLoading
                ? CircularProgressIndicator(strokeWidth: 2)
                : Icon(Icons.refresh),
              label: Text(_isLoading ? 'Fetching...' : 'Get Device Info'),
            ),
            SizedBox(height: 20),
            if (_errorMessage != null)
              Card(
                color: Colors.red.shade50,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(_errorMessage!, style: TextStyle(color: Colors.red)),
                ),
              ),
            if (_deviceInfo != null) ...[
              _buildInfoTile('Battery Level', '${_deviceInfo!.batteryLevel}%'),
              _buildInfoTile('Device Model', _deviceInfo!.deviceModel),
              _buildInfoTile('Charging Status',
                _deviceInfo!.isCharging ? 'Charging' : 'Not Charging'),
              _buildInfoTile('System Time',
                _deviceInfo!.systemTime.toLocal().toString()),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Card(
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(value, style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
```

## API Reference

### DeviceInfoChannel

Main class for communicating with native platforms.

#### Static Methods

##### `getDeviceInfo()` → `Future<DeviceInfo>`

Retrieves comprehensive device information from the native platform.

**Returns:** A Future that completes with a `DeviceInfo` object containing:

- Battery level percentage
- Device model/manufacturer
- Charging status
- Current system time

**Throws:** `Exception` if platform communication fails or device info is unavailable

**Example:**

```dart
final deviceInfo = await DeviceInfoChannel.getDeviceInfo();
```

### DeviceInfo

Data model representing device information with type safety.

#### Properties

- **`batteryLevel`** (`int`): Battery charge percentage (0-100)
- **`deviceModel`** (`String`): Device manufacturer and model
- **`isCharging`** (`bool`): Whether device is currently charging
- **`systemTime`** (`DateTime`): Current system timestamp in UTC

#### Methods

- **`fromMap(Map<String, dynamic> map)`**: Creates instance from native data
- **`toMap()`** → `Map<String, dynamic>`: Converts to map for serialization
- **`fromJson(String source)`**: Creates instance from JSON string
- **`toJson()`** → `String`: Converts to JSON string
- **`copyWith(...)`**: Creates copy with modified properties

#### Example Data Structure

```dart
DeviceInfo(
  batteryLevel: 87,
  deviceModel: "Google Pixel 6",
  isCharging: true,
  systemTime: DateTime.parse("2024-01-15T14:30:00Z"),
)
```

### DeviceInfoWidget

Pre-built Material Design widget for displaying device information.

#### Features

- **Material Design**: Follows Material 3 design guidelines
- **Loading States**: Shows progress indicators during data fetch
- **Error Handling**: Displays user-friendly error messages
- **Refresh Button**: Allows manual data refresh
- **Responsive Layout**: Adapts to different screen sizes
- **Accessibility**: Supports screen readers and keyboard navigation

## Data Format

### Native Platform Response

Both Android and iOS implementations return data in this standardized JSON format:

```json
{
  "batteryLevel": 85,
  "deviceModel": "Samsung SM-G973F",
  "isCharging": false,
  "systemTime": "2024-01-15T14:30:00.123Z"
}
```

### Platform-Specific Notes

#### Android Data Sources

- **Battery Level**: `BatteryManager.BATTERY_PROPERTY_CAPACITY`
- **Device Model**: `"${Build.MANUFACTURER} ${Build.MODEL}"`
- **Charging Status**: `BatteryManager.EXTRA_STATUS` from battery intent
- **System Time**: `SimpleDateFormat` with UTC timezone

#### iOS Data Sources

- **Battery Level**: `UIDevice.current.batteryLevel * 100`
- **Device Model**: `UIDevice.current.model`
- **Charging Status**: `UIDevice.current.batteryState`
- **System Time**: `ISO8601DateFormatter` with fractional seconds

## Error Handling

The plugin provides comprehensive error handling for robust applications:

```dart
try {
  final deviceInfo = await DeviceInfoChannel.getDeviceInfo();
  // Use device information
} catch (e) {
  if (e.toString().contains('DEVICE_INFO_ERROR')) {
    // Handle platform-specific errors (battery access, permissions, etc.)
    print('Platform error: Unable to access device information');
  } else if (e is PlatformException) {
    // Handle Flutter platform channel errors
    print('Platform channel error: ${e.message}');
  } else {
    // Handle parsing or other errors
    print('Unexpected error: $e');
  }
}
```

### Common Error Scenarios

1. **Battery Monitoring Disabled**: iOS requires explicit battery monitoring
2. **Permissions Issues**: Some Android versions may restrict battery access
3. **Platform Channel Failures**: Network or system service unavailability
4. **Data Parsing Errors**: Malformed responses from native platforms

## Development & Debugging

### Building from Source

```bash
# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Build for specific platforms
flutter build apk --debug          # Android debug
flutter build ios --debug          # iOS debug
flutter run --debug                # Run in debug mode
```

### Testing Native Code

#### Android Testing

```bash
# Run with verbose Android logging
flutter run --debug --verbose
# Check Android logs
adb logcat | grep DeviceInfoChannel
```

#### iOS Testing

```bash
# Open iOS simulator logs
open -a Console
# Filter for device_info_channel logs
```

## Attribution & References

This plugin implementation is based on official Flutter documentation and platform-specific APIs:

### Flutter Framework References

- **[Flutter Plugin Development Guide](https://flutter.dev/to/develop-packages)** - Official plugin architecture
- **[Platform Channels Documentation](https://docs.flutter.dev/platform-integration/platform-channels)** - MethodChannel implementation
- **[Writing Package Pages](https://dart.dev/tools/pub/writing-package-pages)** - Package documentation standards

### Android API Documentation

- **[BatteryManager Reference](https://developer.android.com/reference/android/os/BatteryManager)** - Battery information APIs
- **[Build Class Documentation](https://developer.android.com/reference/android/os/Build)** - Device information constants
- **[Context.getSystemService()](<https://developer.android.com/reference/android/content/Context#getSystemService(java.lang.String)>)** - System service access

### iOS API Documentation

- **[UIDevice Class Reference](https://developer.apple.com/documentation/uikit/uidevice)** - Device information APIs
- **[ISO8601DateFormatter](https://developer.apple.com/documentation/foundation/iso8601dateformatter)** - Date formatting utilities

### Code Patterns & Best Practices

- **Flutter Plugin Template**: Standard plugin structure from `flutter create --template=plugin`
- **Material Design Guidelines**: UI component design principles
- **Dart Language Conventions**: Code style and naming patterns from [Dart Style Guide](https://dart.dev/effective-dart/style)

## Contributing

We welcome contributions! Please follow these guidelines:

1. **Fork the repository** and create a feature branch
2. **Follow coding standards**: Use `dart format` and `dart analyze`
3. **Add tests** for new functionality
4. **Update documentation** for API changes
5. **Test on both platforms** before submitting
6. **Create detailed pull requests** with clear descriptions

### Development Setup

```bash
# Clone and setup
git clone <repository-url>
cd varosa_task
flutter pub get

# Run code generation
dart run build_runner build

# Format and analyze
dart format .
dart analyze
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history and breaking changes.
