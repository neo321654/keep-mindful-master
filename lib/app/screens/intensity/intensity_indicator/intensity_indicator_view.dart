import 'package:flutter/material.dart';

import '../../../../generated/assets.gen.dart';
import '../../../shared/widgets/widgets.dart';
import 'intensity_indicator_props.dart';

const _iconHeight = 14.0;
const _iconWidth = 12.0;
const _spaceBetweenElements = 8.0;

class IntensityIndicator extends StatelessWidget {
  const IntensityIndicator({required this.props, super.key});

  final IntensityIndicatorProps props;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          props.intensity.toStringAsFixed(0),
          style: theme.textTheme.displaySmall?.copyWith(
            color: theme.colorScheme.onBackground,
          ),
        ),
        const WidthSpacer(_spaceBetweenElements),
        Assets.icons.thunderOutlined.svg(
          height: _iconHeight,
          width: _iconWidth,
          colorFilter:
              ColorFilter.mode(theme.colorScheme.onBackground, BlendMode.srcIn),
        ),
      ],
    );
  }
}
