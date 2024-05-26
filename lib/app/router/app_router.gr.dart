// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i20;
import 'package:flutter/material.dart' as _i21;
import 'package:keep_mindful/app/router/app_router.dart' as _i11;
import 'package:keep_mindful/app/router/shell_routes/settings_shell.dart'
    as _i14;
import 'package:keep_mindful/app/screens/about_app/about_app_screen.dart'
    as _i1;
import 'package:keep_mindful/app/screens/awakening/awakening_screen.dart'
    as _i2;
import 'package:keep_mindful/app/screens/duration/duration_screen.dart' as _i3;
import 'package:keep_mindful/app/screens/faq/faq_screen.dart' as _i4;
import 'package:keep_mindful/app/screens/index/index_screen.dart' as _i7;
import 'package:keep_mindful/app/screens/index_awakening/index_awakening_screen.dart'
    as _i5;
import 'package:keep_mindful/app/screens/index_metronome/index_metronome_screen.dart'
    as _i6;
import 'package:keep_mindful/app/screens/index_timer/index_timer_screen.dart'
    as _i8;
import 'package:keep_mindful/app/screens/intensity/intensity_screen.dart'
    as _i9;
import 'package:keep_mindful/app/screens/language/language_screen.dart' as _i10;
import 'package:keep_mindful/app/screens/metronome/metronome_screen.dart'
    as _i12;
import 'package:keep_mindful/app/screens/settings/settings_screen.dart' as _i13;
import 'package:keep_mindful/app/screens/splash/splash_screen.dart' as _i15;
import 'package:keep_mindful/app/screens/terms_conditions/terms_conditions_screen.dart'
    as _i16;
import 'package:keep_mindful/app/screens/theme/theme_screen.dart' as _i17;
import 'package:keep_mindful/app/screens/timer/timer_screen.dart' as _i18;
import 'package:keep_mindful/app/screens/wake_up_mode/wake_up_mode_screen.dart'
    as _i19;
import 'package:keep_mindful/features/features.dart' as _i22;

abstract class $AppRouter extends _i20.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i20.PageFactory> pagesMap = {
    AboutAppScreenRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AboutAppScreen(),
      );
    },
    AwakeningScreenRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AwakeningScreen(),
      );
    },
    DurationScreenRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.DurationScreen(),
      );
    },
    FaqScreenRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.FaqScreen(),
      );
    },
    IndexAwakeningScreenRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.IndexAwakeningScreen(),
      );
    },
    IndexMetronomeScreenRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.IndexMetronomeScreen(),
      );
    },
    IndexScreenRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.IndexScreen(),
      );
    },
    IndexTimerScreenRoute.name: (routeData) {
      final args = routeData.argsAs<IndexTimerScreenRouteArgs>(
          orElse: () => const IndexTimerScreenRouteArgs());
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.IndexTimerScreen(key: args.key),
      );
    },
    IntensityScreenRoute.name: (routeData) {
      final args = routeData.argsAs<IntensityScreenRouteArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.IntensityScreen(
          mode: args.mode,
          key: args.key,
        ),
      );
    },
    LanguageScreenRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.LanguageScreen(),
      );
    },
    MainRouter.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.MainRouterPage(),
      );
    },
    MetronomeScreenRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.MetronomeScreen(),
      );
    },
    SettingsScreenRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.SettingsScreen(),
      );
    },
    SettingsShellRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.SettingsShell(),
      );
    },
    SplashScreenRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.SplashScreen(),
      );
    },
    TermsConditionsScreenRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.TermsConditionsScreen(),
      );
    },
    ThemeScreenRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.ThemeScreen(),
      );
    },
    TimerScreenRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.TimerScreen(),
      );
    },
    WakeUpModeScreenRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.WakeUpModeScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AboutAppScreen]
class AboutAppScreenRoute extends _i20.PageRouteInfo<void> {
  const AboutAppScreenRoute({List<_i20.PageRouteInfo>? children})
      : super(
          AboutAppScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'AboutAppScreenRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AwakeningScreen]
class AwakeningScreenRoute extends _i20.PageRouteInfo<void> {
  const AwakeningScreenRoute({List<_i20.PageRouteInfo>? children})
      : super(
          AwakeningScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'AwakeningScreenRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i3.DurationScreen]
class DurationScreenRoute extends _i20.PageRouteInfo<void> {
  const DurationScreenRoute({List<_i20.PageRouteInfo>? children})
      : super(
          DurationScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'DurationScreenRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i4.FaqScreen]
class FaqScreenRoute extends _i20.PageRouteInfo<void> {
  const FaqScreenRoute({List<_i20.PageRouteInfo>? children})
      : super(
          FaqScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'FaqScreenRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i5.IndexAwakeningScreen]
class IndexAwakeningScreenRoute extends _i20.PageRouteInfo<void> {
  const IndexAwakeningScreenRoute({List<_i20.PageRouteInfo>? children})
      : super(
          IndexAwakeningScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'IndexAwakeningScreenRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i6.IndexMetronomeScreen]
class IndexMetronomeScreenRoute extends _i20.PageRouteInfo<void> {
  const IndexMetronomeScreenRoute({List<_i20.PageRouteInfo>? children})
      : super(
          IndexMetronomeScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'IndexMetronomeScreenRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i7.IndexScreen]
class IndexScreenRoute extends _i20.PageRouteInfo<void> {
  const IndexScreenRoute({List<_i20.PageRouteInfo>? children})
      : super(
          IndexScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'IndexScreenRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i8.IndexTimerScreen]
class IndexTimerScreenRoute
    extends _i20.PageRouteInfo<IndexTimerScreenRouteArgs> {
  IndexTimerScreenRoute({
    _i21.Key? key,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          IndexTimerScreenRoute.name,
          args: IndexTimerScreenRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'IndexTimerScreenRoute';

  static const _i20.PageInfo<IndexTimerScreenRouteArgs> page =
      _i20.PageInfo<IndexTimerScreenRouteArgs>(name);
}

class IndexTimerScreenRouteArgs {
  const IndexTimerScreenRouteArgs({this.key});

  final _i21.Key? key;

  @override
  String toString() {
    return 'IndexTimerScreenRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.IntensityScreen]
class IntensityScreenRoute
    extends _i20.PageRouteInfo<IntensityScreenRouteArgs> {
  IntensityScreenRoute({
    required _i22.IntensityMode mode,
    _i21.Key? key,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          IntensityScreenRoute.name,
          args: IntensityScreenRouteArgs(
            mode: mode,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'IntensityScreenRoute';

  static const _i20.PageInfo<IntensityScreenRouteArgs> page =
      _i20.PageInfo<IntensityScreenRouteArgs>(name);
}

class IntensityScreenRouteArgs {
  const IntensityScreenRouteArgs({
    required this.mode,
    this.key,
  });

  final _i22.IntensityMode mode;

  final _i21.Key? key;

  @override
  String toString() {
    return 'IntensityScreenRouteArgs{mode: $mode, key: $key}';
  }
}

/// generated route for
/// [_i10.LanguageScreen]
class LanguageScreenRoute extends _i20.PageRouteInfo<void> {
  const LanguageScreenRoute({List<_i20.PageRouteInfo>? children})
      : super(
          LanguageScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'LanguageScreenRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i11.MainRouterPage]
class MainRouter extends _i20.PageRouteInfo<void> {
  const MainRouter({List<_i20.PageRouteInfo>? children})
      : super(
          MainRouter.name,
          initialChildren: children,
        );

  static const String name = 'MainRouter';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i12.MetronomeScreen]
class MetronomeScreenRoute extends _i20.PageRouteInfo<void> {
  const MetronomeScreenRoute({List<_i20.PageRouteInfo>? children})
      : super(
          MetronomeScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'MetronomeScreenRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i13.SettingsScreen]
class SettingsScreenRoute extends _i20.PageRouteInfo<void> {
  const SettingsScreenRoute({List<_i20.PageRouteInfo>? children})
      : super(
          SettingsScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsScreenRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i14.SettingsShell]
class SettingsShellRoute extends _i20.PageRouteInfo<void> {
  const SettingsShellRoute({List<_i20.PageRouteInfo>? children})
      : super(
          SettingsShellRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsShellRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i15.SplashScreen]
class SplashScreenRoute extends _i20.PageRouteInfo<void> {
  const SplashScreenRoute({List<_i20.PageRouteInfo>? children})
      : super(
          SplashScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashScreenRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i16.TermsConditionsScreen]
class TermsConditionsScreenRoute extends _i20.PageRouteInfo<void> {
  const TermsConditionsScreenRoute({List<_i20.PageRouteInfo>? children})
      : super(
          TermsConditionsScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'TermsConditionsScreenRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i17.ThemeScreen]
class ThemeScreenRoute extends _i20.PageRouteInfo<void> {
  const ThemeScreenRoute({List<_i20.PageRouteInfo>? children})
      : super(
          ThemeScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'ThemeScreenRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i18.TimerScreen]
class TimerScreenRoute extends _i20.PageRouteInfo<void> {
  const TimerScreenRoute({List<_i20.PageRouteInfo>? children})
      : super(
          TimerScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'TimerScreenRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i19.WakeUpModeScreen]
class WakeUpModeScreenRoute extends _i20.PageRouteInfo<void> {
  const WakeUpModeScreenRoute({List<_i20.PageRouteInfo>? children})
      : super(
          WakeUpModeScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'WakeUpModeScreenRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}
