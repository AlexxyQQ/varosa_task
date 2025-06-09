import 'package:flutter/material.dart';
import 'device_info_channel.dart';

/// A widget that displays device information fetched via MethodChannel
class DeviceInfoWidget extends StatefulWidget {
  const DeviceInfoWidget({super.key});

  @override
  State<DeviceInfoWidget> createState() => _DeviceInfoWidgetState();
}

class _DeviceInfoWidgetState extends State<DeviceInfoWidget> {
  DeviceInfo? _deviceInfo;
  bool _isLoading = false;
  String? _error;

  Future<void> _fetchDeviceInfo() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final deviceInfo = await DeviceInfoChannel.getDeviceInfo();
      setState(() {
        _deviceInfo = deviceInfo;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Information'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _fetchDeviceInfo,
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.refresh),
              label: Text(_isLoading ? 'Fetching...' : 'Fetch Device Info'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 20),
            if (_error != null)
              Card(
                color: Colors.red.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.error, color: Colors.red),
                          SizedBox(width: 8),
                          Text(
                            'Error',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(_error!, style: const TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ),
            if (_deviceInfo != null) ...[
              const Text(
                'Device Information:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildInfoCard(
                'Battery Level',
                '${_deviceInfo!.batteryLevel}%',
                Icons.battery_std,
              ),
              _buildInfoCard(
                'Device Model',
                _deviceInfo!.deviceModel,
                Icons.phone_android,
              ),
              _buildInfoCard(
                'Charging Status',
                _deviceInfo!.isCharging ? 'Charging' : 'Not Charging',
                _deviceInfo!.isCharging
                    ? Icons.battery_charging_full
                    : Icons.battery_std,
              ),
              _buildInfoCard(
                'System Time',
                '${_deviceInfo!.systemTime.toLocal().toString().substring(0, 19)}',
                Icons.access_time,
              ),
            ] else if (!_isLoading && _error == null)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Icon(Icons.info_outline, size: 48, color: Colors.grey),
                      SizedBox(height: 12),
                      Text(
                        'Tap the button above to fetch device information',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
