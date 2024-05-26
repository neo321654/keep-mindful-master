import 'package:flutter/material.dart';

import '../spacer/spacer.dart';
import 'slider_divisions_painter.dart';
import 'slider_props.dart';

const _sliderBottomPadding = 10.0;
const _thumbSize = 13.0;
const _divisionsBottomPadding = 5.0;
const _valuesPadding = _thumbSize - 4.0;

class AppSlider extends StatelessWidget {
  const AppSlider({super.key, required this.props});

  final AppSliderProps props;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final contentList = <Widget>[
      const HeightSpacer(_sliderBottomPadding),
      Slider(
        value: props.value ?? 0.0,
        onChanged: props.onChange,
        max: props.max,
        min: props.min,
      )
    ];

    if (props.divisions != null) {
      contentList.addAll([
        const HeightSpacer(_sliderBottomPadding),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: _thumbSize),
          child: CustomPaint(
            size: const Size.fromHeight(20.0),
            painter: SliderDivisionsPainter(
                dividerColor: theme.colorScheme.onSurface,
                divisions: props.divisions!),
          ),
        ),
        const HeightSpacer(_divisionsBottomPadding),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: _valuesPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                props.min.toStringAsFixed(0),
                style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w300),
              ),
              Text(
                props.max.toStringAsFixed(0),
                style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        )
      ]);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: contentList,
    );
  }
}
