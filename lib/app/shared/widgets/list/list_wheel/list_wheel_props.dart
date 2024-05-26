import 'package:flutter/material.dart';

class ListWheelProps {
  const ListWheelProps(
      {required this.count,
      required this.title,
      this.onChanged,
      this.controller,
      this.enabled = true,
      this.direction = Axis.vertical,
      this.startFromZero = true});

  final int count;
  final String title;
  final Axis direction;
  final bool enabled;
  final void Function(int)? onChanged;
  final bool startFromZero;
  final FixedExtentScrollController? controller;
}
