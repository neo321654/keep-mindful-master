import 'package:flutter/material.dart';

extension TimeOfDayConverter on TimeOfDay {
  DateTime toDateTime() {
    final now = DateTime.now();

    final nowTimeInMinutes = now.hour * 60 + now.minute;
    final currentTimeOfDay = hour * 60 + minute;

    if (nowTimeInMinutes < currentTimeOfDay) {
      return DateTime(now.year, now.month, now.day, hour, minute);
    }

    final increasedDate = now.add(const Duration(days: 1));

    return DateTime(increasedDate.year, increasedDate.month, increasedDate.day,
        hour, minute, increasedDate.second);
  }
}
