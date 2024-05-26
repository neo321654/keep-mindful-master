import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart'
    hide BottomNavigationBar, BottomNavigationBarItem;

import '../../../features/features.dart';
import '../../../generated/assets.gen.dart';
import '../../../l10n/app_loc_extension.dart';
import '../../router/router.dart';
import '../../shared/shared.dart';

@RoutePage()
class IndexMetronomeScreen extends StatelessWidget {
  const IndexMetronomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;

    final items = [
      BottomNavigationBarItem(
          Assets.icons.metronomeTempoBeat, loc.metronomeTitle),
      BottomNavigationBarItem(Assets.icons.flashSettings, loc.intensity),
      BottomNavigationBarItem(Assets.icons.settings, loc.settingsTitle),
    ];

    return AutoTabsRouter(
      homeIndex: 0,
      routes: [
        const MetronomeScreenRoute(),
        IntensityScreenRoute(mode: IntensityMode.metronome),
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
