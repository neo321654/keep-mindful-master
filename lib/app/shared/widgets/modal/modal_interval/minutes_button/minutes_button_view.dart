import 'package:flutter/material.dart';

import '../../../../../../l10n/app_loc_extension.dart';
import '../../../../shared.dart';
import 'minutes_button_props.dart';

const _buttonSize = 64.0;

class MinutesButton extends StatelessWidget {
  const MinutesButton({required this.props, super.key});

  final MinutesButtonProps props;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = context.loc;
    final min = props.minutes;
    return SizedBox(
      key: Key('min_$min'),
      height: _buttonSize,
      width: _buttonSize,
      child: Center(
        child: Button(
          props: ButtonProps(
            title: '$min',
            subtitle: loc.min,
            onPressed: () => props.onPressed?.call(min),
            buttonStyle:
                ButtonStyles.byType(theme, ButtonType.circleTitleSubtitle),
          ),
        ),
      ),
    );
  }
}
