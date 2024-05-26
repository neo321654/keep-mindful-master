import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../l10n/app_loc_extension.dart';
import '../../router/router.dart';
import '../../shared/shared.dart';

const _paddingDefault = 24.0;
const _paddingSmall = 12.0;
const _horizontalPadding = 30.0;
const _switherTileInnerPadding =
    EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0);

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  void _navigateToLanguage() {
    GetIt.instance<AppRouter>().push(const LanguageScreenRoute());
  }

  void _navigateToTermsConditions() {
    GetIt.instance<AppRouter>().push(const TermsConditionsScreenRoute());
  }

  void _onSwitherTapped(bool isSelected) {
    // TODO: Add implementation
    throw UnimplementedError();
  }

  void _navigateToAboutApp() {
    GetIt.instance<AppRouter>().push(const AboutAppScreenRoute());
  }

  void _navigateToFaq() {
    GetIt.instance<AppRouter>().push(const FaqScreenRoute());
  }

  void _navigateToWakeUpMode() {
    GetIt.instance<AppRouter>().push(const WakeUpModeScreenRoute());
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);
    return Semantics(
      label: loc.settingsTitle,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeightSpacer(_paddingDefault),
            Text(
              loc.settingsTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.displaySmall?.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
            const HeightSpacer(_paddingDefault),
            SelectableListTile(
              props: SelectableListTileProps(
                  title: loc.settingsLanguage, onPressed: _navigateToLanguage),
            ),
            const HeightSpacer(_paddingDefault),
            SelectableListTile(
              props: SelectableListTileProps(
                  title: loc.settingsWakeUpMode,
                  onPressed: _navigateToWakeUpMode),
            ),
            const HeightSpacer(_paddingDefault),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: _paddingSmall),
              child: Text(
                loc.settingsNotifications,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onBackground,
                ),
              ),
            ),
            const HeightSpacer(_paddingSmall),
            SelectableListTile(
              props: SelectableListTileProps(
                padding: _switherTileInnerPadding,
                title: loc.settingsBatteryLow,
                trailing: Switcher(
                  props: SwitcherProps(onChange: _onSwitherTapped),
                ),
              ),
            ),
            const HeightSpacer(_paddingDefault),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: _paddingSmall),
              child: Text(
                loc.settingsDetails,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onBackground,
                ),
              ),
            ),
            const HeightSpacer(_paddingSmall),
            SelectableListTile(
              props: SelectableListTileProps(
                  title: loc.settingsAboutApp, onPressed: _navigateToAboutApp),
            ),
            const HeightSpacer(_paddingSmall),
            SelectableListTile(
              props: SelectableListTileProps(
                  title: loc.settingsTermsConditions,
                  onPressed: _navigateToTermsConditions),
            ),
            const HeightSpacer(_paddingSmall),
            SelectableListTile(
              props: SelectableListTileProps(
                  title: loc.settingsFaq, onPressed: _navigateToFaq),
            ),
          ],
        ),
      ),
    );
  }
}
