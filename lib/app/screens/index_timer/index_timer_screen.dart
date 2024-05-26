import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart'
    hide BottomNavigationBar, BottomNavigationBarItem;

import '../../../features/features.dart';
import '../../../generated/assets.gen.dart';
import '../../../l10n/app_loc_extension.dart';
import '../../router/app_router.gr.dart';
import '../../shared/shared.dart';

@RoutePage()
class IndexTimerScreen extends StatelessWidget {
  IndexTimerScreen({super.key});

  final items = [
    Assets.icons.timer,
    Assets.icons.duration,
    Assets.icons.flashSettings,
    Assets.icons.settings
  ];

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final items = [
      BottomNavigationBarItem(Assets.icons.timer, loc.timerTitle),
      BottomNavigationBarItem(Assets.icons.duration, loc.durationTitle),
      BottomNavigationBarItem(Assets.icons.flashSettings, loc.intensity),
      BottomNavigationBarItem(Assets.icons.settings, loc.settingsTitle),
    ];
    return AutoTabsRouter(
      homeIndex: 0,
      routes: [
        const TimerScreenRoute(),
        const DurationScreenRoute(),
        IntensityScreenRoute(mode: IntensityMode.timer),
        const SettingsShellRoute()
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            props: BottomNavigationBarProps(
                items: items,
                selectedPosition: tabsRouter.activeIndex,
                onPressed: tabsRouter.setActiveIndex),
          ),
        );
      },
    );
  }
}
