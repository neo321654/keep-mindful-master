import 'package:flutter/services.dart';

class RangeInputFormatter extends TextInputFormatter {
  const RangeInputFormatter({required this.min, required this.max});

  final double min;
  final double max;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return newValue;
    }
    if (int.parse(newValue.text) < min) {
      return const TextEditingValue().copyWith(text: min.toStringAsFixed(2));
    }
    return int.parse(newValue.text) > max ? oldValue : newValue;
  }
}
