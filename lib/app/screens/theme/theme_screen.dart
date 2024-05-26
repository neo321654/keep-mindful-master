import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_loc_extension.dart';
import '../../shared/shared.dart';

const _padding = 24.0;
const _tilePadding = EdgeInsets.symmetric(horizontal: 30.0);
const _tileInnerPadding =
    EdgeInsets.only(left: 24.0, bottom: 5.0, top: 5.0, right: 10.0);

@RoutePage()
class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  // TODO: Ridof setstate
  ThemeMode _themeMode = ThemeMode.light;

  void _onThemePressed(ThemeMode mode) {
    if (_themeMode == mode) {
      return;
    }

    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);
    return ColoredBox(
      color: theme.colorScheme.background,
      child: SeparatedColumn(
        separatorBuilder: (_, __) => const HeightSpacer(_padding),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SecondaryTopBar(
            props: SecondaryTopBarProps(title: loc.themeTitle),
          ),
          Padding(
            padding: _tilePadding,
            child: SelectableListTile(
              props: SelectableListTileProps(
                padding: _tileInnerPadding,
                title: loc.themeLight,
                onPressed: () => _onThemePressed(ThemeMode.light),
                trailing: RadioBox(
                  props: RadioBoxProps(
                      value: ThemeMode.light,
                      groupValue: _themeMode,
                      onPressed: _onThemePressed),
                ),
              ),
            ),
          ),
          Padding(
            padding: _tilePadding,
            child: SelectableListTile(
              props: SelectableListTileProps(
                padding: _tileInnerPadding,
                title: loc.themeDark,
                onPressed: () => _onThemePressed(ThemeMode.dark),
                trailing: RadioBox(
                  props: RadioBoxProps(
                      value: ThemeMode.dark,
                      groupValue: _themeMode,
                      onPressed: _onThemePressed),
                ),
              ),
            ),
          ),
          Padding(
            padding: _tilePadding,
            child: SelectableListTile(
              props: SelectableListTileProps(
                padding: _tileInnerPadding,
                title: loc.themeSystem,
                onPressed: () => _onThemePressed(ThemeMode.system),
                trailing: RadioBox(
                  props: RadioBoxProps(
                      value: ThemeMode.system,
                      groupValue: _themeMode,
                      onPressed: _onThemePressed),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
