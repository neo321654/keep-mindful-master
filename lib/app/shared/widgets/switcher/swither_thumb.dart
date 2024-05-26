import 'package:flutter/material.dart';

const _size = 28.0;
const _gradientRadius = 1.9;
const _gradientStops = [0.5, 0.8];

class SwitcherThumb extends StatelessWidget {
  const SwitcherThumb({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final gradient = RadialGradient(
        center: Alignment.topLeft,
        radius: _gradientRadius,
        colors: [theme.colorScheme.shadow, theme.shadowColor],
        stops: _gradientStops);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: gradient,
        shape: BoxShape.circle,
      ),
      child: const SizedBox(
        height: _size,
        width: _size,
      ),
    );
  }
}
