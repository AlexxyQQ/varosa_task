import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'config/constants/flavour/app_flavour.constant.dart';
import 'config/constants/locales/app_locales.constant.dart';
import 'core/app.dart';
import 'core/bootstrap.dart';

void main() async {
  // HttpOverrides.global = MyHttpOverrides();
  bootstrap(
    builder: () => EasyLocalization(
      supportedLocales: AppLocales.appLocales,
      startLocale: const Locale('en', 'GB'),
      path: "assets/translations",
      fallbackLocale: const Locale('en', 'GB'),
      child: const App(),
    ),
    appFlavor: AppFlavor.staging(),
  );
}
