import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../features/features.dart';
import '../l10n/app_loc_extension.dart';
import 'application.config.dart';
import 'router/router.dart';
import 'shared/themes/theme.dart';

@InjectableInit(preferRelativeImports: false)
class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final _appRouter = GetIt.I<AppRouter>();
  final _languageNotifier = GetIt.I<AppLanguageNotifier>();

  @override
  void initState() {
    GetIt.instance.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: _languageNotifier,
        builder: (_, __) {
          return MaterialApp.router(
            onGenerateTitle: (titleContext) => titleContext.loc.appName,
            locale: _languageNotifier.language!.locale,
            routerConfig: _appRouter.config(),
            localizationsDelegates: AppLanguages.appDelegates,
            supportedLocales: AppLanguages.supportedLocales,
            theme: AppTheme.themeData,
            scrollBehavior: const ScrollBehaviorModified(),
          );
        });
  }
}

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics();
}
