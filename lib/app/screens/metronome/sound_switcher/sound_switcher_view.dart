import 'package:flutter/material.dart';

import '../../../../l10n/app_loc_extension.dart';
import '../../../shared/shared.dart';
import 'sound_switcher_props.dart';

const _paddingBetweenElements = 10.0;

class SoundSwitcher extends StatelessWidget {
  const SoundSwitcher({required this.props, super.key});
  final SoundSwitcherProps props;

  void _onPressed() {
    props.onChanged?.call(!props.isSelected);
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: _onPressed,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Switcher(
            props: SwitcherProps(
              value: props.isSelected,
              onChange: props.onChanged,
            ),
          ),
          const WidthSpacer(_paddingBetweenElements),
          Expanded(
            child: Text(
              loc.metronomeSoundSwitherTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onBackground,
                  fontWeight: FontWeight.w300),
            ),
          )
        ],
      ),
    );
  }
}
