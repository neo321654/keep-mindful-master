import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import 'app/application.dart';
import 'app/di/app_injections.dart';
import 'app/hive/hive_app.dart';
import 'features/features.dart';

Future<void> main() async {
  const environment = String.fromEnvironment('MODE', defaultValue: 'DEV');
  String envFileName;

  switch (environment) {
    case 'STAGE':
      envFileName = '.env/.stage.env';
    case 'PROD':
      envFileName = '.env/.prod.env';
    default:
      envFileName = '.env/.dev.env';
  }

  await dotenv.load(fileName: envFileName);

  await HiveApp().initHive();

  WidgetsFlutterBinding.ensureInitialized();

  AppInjections.register();

  GetIt.instance<AppLanguageNotifier>().fetchLanguage();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark),
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const Application());
  });
}
