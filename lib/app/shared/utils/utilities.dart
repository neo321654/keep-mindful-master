import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtension on String? {
  bool get isEmail {
    final regExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );
    if (regExp.hasMatch(this!)) {
      return true;
    } else {
      return false;
    }
  }
}

void logger(dynamic input, {String tag = '[DEBUG]'}) {
  debugPrint('$tag -- $input');
}

const String dateFormatter = 'dd MMMM yy';

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  /// Compare with current time to set the string value of date to 'today' or
  /// 'yesterday'
  String showAsString() {
    DateTime now = DateTime.now();
    switch (DateTime(year, month, day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays) {
      case -1:
        // TODO: add intl
        return 'Yesterday';
      case 0:
      // TODO: add intl
        return 'Today';
      default:
        return formatDate();
    }
  }
}

String ordinal(int number) {
  if (!(number >= 1 && number <= 100)) {
    throw ('Invalid number');
  }

  if (number >= 11 && number <= 13) {
    return '${number}th';
  }

  switch (number % 10) {
    case 1:
      return '${number}st';
    case 2:
      return '${number}nd';
    case 3:
      return '${number}rd';
    default:
      return '${number}th';
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
