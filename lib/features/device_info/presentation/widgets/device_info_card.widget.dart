import 'package:device_info_channel/device_info_channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../config/constants/date_time/date_time_formatter_string.constant.dart';
import '../../../../config/constants/fonts/app_text_style.dart';
import '../../../../config/constants/size/app_size.constant.dart';
import '../../../../core/common/presentation/extensions/date_time_helper.extension.dart';
import '../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../bloc/device_info.bloc.dart';
import 'info_card.widget.dart';

class DeviceInfoCardWidget extends StatelessWidget {
  final DeviceInfo deviceInfo;

  const DeviceInfoCardWidget({super.key, required this.deviceInfo});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<DeviceInfoBloc>().add(const FetchDeviceInfoEvent());
        await Future.delayed(const Duration(milliseconds: 500));
      },
      color: PrimitiveColors.blue,
      backgroundColor: Colors.white,
      child: DecoratedBox(
        decoration: const BoxDecoration(borderRadius: AppSize.allRadius16),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            constraints: BoxConstraints(minHeight: 0.7.sh),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: PrimitiveColors.blue,
                      size: 24,
                    ),
                    AppSize.horizontalMargin8,
                    AppText(
                      'Device Information',
                      translate: false,
                      style: AppTextStyles.title.copyWith(
                        color: PrimitiveColors.blue,
                      ),
                    ),
                  ],
                ),
                AppSize.verticalMargin20,
                InfoCardWidget(
                  icon: Icons.battery_full,
                  label: 'Battery Level',
                  value: '${deviceInfo.batteryLevel}%',
                  color: _getBatteryColor(deviceInfo.batteryLevel),
                ),
                AppSize.verticalMargin12,
                InfoCardWidget(
                  icon: Icons.phone_android,
                  label: 'Device Model',
                  value: deviceInfo.deviceModel,
                  color: Colors.green,
                ),
                AppSize.verticalMargin12,
                InfoCardWidget(
                  icon: deviceInfo.isCharging ? Icons.power : Icons.power_off,
                  label: 'Charging Status',
                  value: deviceInfo.isCharging ? 'Charging' : 'Not Charging',
                  color: deviceInfo.isCharging ? Colors.green : Colors.orange,
                ),
                AppSize.verticalMargin12,
                InfoCardWidget(
                  icon: Icons.access_time,
                  label: 'System Time',
                  value: deviceInfo.systemTime.toLocal().formatDateTime(
                    DateTimeFormatterString.fullDayOfWeekMonthDayYear,
                  ),
                  color: Colors.purple,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getBatteryColor(int level) {
    if (level <= 20) return Colors.red;
    if (level <= 50) return Colors.orange;
    return Colors.green;
  }
}
