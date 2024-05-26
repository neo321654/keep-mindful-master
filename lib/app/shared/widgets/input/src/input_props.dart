import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../shared.dart';

const _defaultMinWidth = 30.0;

class InputProps {
  const InputProps(
      {this.controller,
      this.initialValue,
      this.hintText,
      this.trailingIcon,
      this.maxLength,
      this.expands = false,
      this.maxWidth = double.infinity,
      this.onChanged,
      this.autovalidateMode,
      this.enabled = true,
      this.validator,
      this.autoFocus,
      this.inputFormatters,
      this.minWidth = _defaultMinWidth,
      this.textAlign = TextAlign.start,
      this.textCapitalization = TextCapitalization.none,
      this.keyboardType,
      required this.style});

  final String? initialValue;
  final TextEditingController? controller;
  final TextAlign textAlign;
  final String? hintText;
  final SvgGenImage? trailingIcon;
  final void Function(String)? onChanged;
  final int? maxLength;
  final bool expands;
  final bool enabled;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final bool? autoFocus;
  final List<TextInputFormatter>? inputFormatters;
  final double minWidth;
  final double maxWidth;
  final InputStyle style;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
}
