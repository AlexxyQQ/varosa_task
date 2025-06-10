import 'package:auto_route/auto_route.dart';
import 'package:device_info_channel/device_info_channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/size/app_size.constant.dart';
import '../../../../core/common/data/models/error/app_error.model.dart';
import '../../../../core/common/presentation/views/widgets/app_button.widget.dart';
import '../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../../../../core/di/main.di.dart';
import '../bloc/device_info.bloc.dart';
import '../widgets/device_info_card.widget.dart';
import '../widgets/empty_state.widget.dart';
import '../widgets/error_message.widget.dart';

@RoutePage()
class DeviceInfoPage extends StatelessWidget implements AutoRouteWrapper {
  const DeviceInfoPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => sl<DeviceInfoBloc>(), child: this);
  }

  void _getDeviceInfo(BuildContext context) {
    context.read<DeviceInfoBloc>().add(const FetchDeviceInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppText('Device Info')),
      body: Padding(
        padding: AppSize.allPadding16,
        child: BlocBuilder<DeviceInfoBloc, DeviceInfoState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppButton.primary(
                  onPressed: state.isLoading
                      ? null
                      : () => _getDeviceInfo(context),
                  label: 'Get Device Information',
                ),
                AppSize.verticalMargin24,
                if (state.error != null)
                  ErrorMessageWidget(message: state.error!.message)
                else if (state.deviceInfo != null)
                  DeviceInfoCardWidget(deviceInfo: state.deviceInfo!)
                else
                  const EmptyStateWidget(),
              ],
            );
          },
        ),
      ),
    );
  }
}
