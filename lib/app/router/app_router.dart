import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Page,Route')
class AppRouter extends $AppRouter {
  List<AutoRoute> get _settingsShell {
    return [
      CustomRoute(
        path: '',
        page: SettingsScreenRoute.page,
        transitionsBuilder: TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
      ),
      AutoRoute(
        page: LanguageScreenRoute.page,
        path: 'language',
      ),
      AutoRoute(
        page: AboutAppScreenRoute.page,
        path: 'about_app',
      ),
      AutoRoute(
        page: TermsConditionsScreenRoute.page,
        path: 'terms_conditions',
      ),
      AutoRoute(
        page: FaqScreenRoute.page,
        path: 'faq',
      ),
      AutoRoute(
        page: WakeUpModeScreenRoute.page,
        path: 'wake_up_mode',
      ),
    ];
  }

  List<AutoRoute> get _timerRouteChildren {
    return [
      CustomRoute(
        page: TimerScreenRoute.page,
        path: '',
        transitionsBuilder: TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
      ),
      CustomRoute(
        page: DurationScreenRoute.page,
        path: 'duration',
        transitionsBuilder: TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
      ),
      CustomRoute(
        page: IntensityScreenRoute.page,
        path: 'intensity',
        transitionsBuilder: TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
      ),
      CustomRoute(
          page: SettingsShellRoute.page,
          path: 'settings',
          transitionsBuilder: TransitionsBuilders.noTransition,
          durationInMilliseconds: 0,
          children: _settingsShell),
    ];
  }

  List<AutoRoute> get _metronomeRouteChildren {
    return [
      CustomRoute(
        page: MetronomeScreenRoute.page,
        path: '',
        transitionsBuilder: TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
      ),
      CustomRoute(
        page: IntensityScreenRoute.page,
        path: 'intensity',
        transitionsBuilder: TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
      ),
      CustomRoute(
          page: SettingsShellRoute.page,
          path: 'settings',
          transitionsBuilder: TransitionsBuilders.noTransition,
          durationInMilliseconds: 0,
          children: _settingsShell),
    ];
  }

  List<AutoRoute> get _awakeningRouteChildren {
    return [
      CustomRoute(
        page: AwakeningScreenRoute.page,
        path: '',
        transitionsBuilder: TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
      ),
      CustomRoute(
          page: SettingsShellRoute.page,
          path: 'settings',
          transitionsBuilder: TransitionsBuilders.noTransition,
          durationInMilliseconds: 0,
          children: _settingsShell),
    ];
  }

  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          initial: true,
          page: SplashScreenRoute.page,
          path: '/splash',
          transitionsBuilder: TransitionsBuilders.noTransition,
          durationInMilliseconds: 0,
        ),
        AutoRoute(page: IndexScreenRoute.page, path: '/index', children: [
          CustomRoute(
              page: IndexTimerScreenRoute.page,
              path: 'timer',
              transitionsBuilder: TransitionsBuilders.noTransition,
              durationInMilliseconds: 0,
              children: _timerRouteChildren),
          CustomRoute(
              page: IndexMetronomeScreenRoute.page,
              path: 'metronome',
              transitionsBuilder: TransitionsBuilders.noTransition,
              durationInMilliseconds: 0,
              children: _metronomeRouteChildren),
          CustomRoute(
              page: IndexAwakeningScreenRoute.page,
              path: 'awakening',
              transitionsBuilder: TransitionsBuilders.noTransition,
              durationInMilliseconds: 0,
              children: _awakeningRouteChildren),
        ]),
      ];
}

@RoutePage(name: 'MainRouter')
class MainRouterPage extends AutoRouter {
  const MainRouterPage({super.key});
}
