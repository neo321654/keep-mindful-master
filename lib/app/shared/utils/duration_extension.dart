extension DurationExtension on Duration {
  Duration copyWith(
      {int? days,
      int? hours,
      int? minutes,
      int? seconds,
      int? milliseconds,
      int? microseconds}) {
    return Duration(
        days: days ?? inDays,
        hours: hours ?? inHours.remainder(24),
        minutes: minutes ?? inMinutes.remainder(60),
        seconds: seconds ?? inSeconds.remainder(60),
        milliseconds: milliseconds ?? inMilliseconds.remainder(1000),
        microseconds: microseconds ?? inMicroseconds.remainder(1000));
  }
}
