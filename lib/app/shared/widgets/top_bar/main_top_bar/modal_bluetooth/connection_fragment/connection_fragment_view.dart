import 'package:flutter/material.dart';

import '../../../../../../../l10n/app_loc_extension.dart';
import '../../../../button/button.dart';
import '../../../../spacer/spacer.dart';
import 'connect_decoration.dart';
import 'connection_fragment_props.dart';

const _wavesBottomPadding = 21.0;
const _horizontalPadding = 43.0;
const _paddingTop = 30.0;
const _paddingBottom = 35.0;

class ConnectionFragment extends StatelessWidget {
  const ConnectionFragment({required this.props, super.key});

  final ConnectionFragmentProps props;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = context.loc;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _horizontalPadding,
      ),
      child: Column(
        children: [
          const HeightSpacer(_paddingTop),
          const Expanded(
            child: ConnectDecoration(),
          ),
          const HeightSpacer(_wavesBottomPadding),
          Button(
            props: ButtonProps(
              title: loc.bluetoothTurnOnButton,
              onPressed: props.onPressed,
              buttonStyle:
                  ButtonStyles.byType(theme, ButtonType.rectangleTextPrimary),
            ),
          ),
          const HeightSpacer(_paddingBottom),
        ],
      ),
    );
  }
}
