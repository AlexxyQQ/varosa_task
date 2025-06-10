//  Initializer
import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/constants/flavour/app_flavour.constant.dart';
import '../config/observers/bloc_observer.dart';
import 'common/domain/services/storage/seeder.service.dart';
import 'di/main.di.dart';

FutureOr<void> bootstrap({
  required AppFlavor appFlavor,
  required FutureOr<Widget> Function() builder,
}) async {
  await runZonedGuarded(
    () async {
      BindingBase.debugZoneErrorsAreFatal = true;
      WidgetsFlutterBinding.ensureInitialized();
      await EasyLocalization.ensureInitialized();
      await appFlavor.loadEnvironment();
      await MainDI().register(appFlavor: appFlavor);
      // Main Bloc observer initialization
      // ! Comment this line to disable bloc observer
      Bloc.observer = sl<AppBlocObserver>();
      // Amplify initialization

      // Lock Rotation
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

      // Seed Data
      await SeederService.seedData();

      // Run the app
      final app = await builder();
      runApp(app);
    },
    (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace, name: "BOOTSTRAP");
    },
  );
}
