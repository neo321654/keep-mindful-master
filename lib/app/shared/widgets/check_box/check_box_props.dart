import 'package:flutter/material.dart';

class CheckBoxProps {
  const CheckBoxProps({this.isSelected = false, this.onPressed});
  final bool isSelected;
  final VoidCallback? onPressed;
}
