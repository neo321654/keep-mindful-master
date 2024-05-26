import 'dart:async';

import 'package:flutter/material.dart';

const _defaultDurationTick = Duration(seconds: 1);

class CountdownTimer extends ValueNotifier<Duration> {
  CountdownTimer(Duration duration)
      : _startDuration = duration,
        super(duration);

  final Duration _startDuration;
  Timer? _timer;

  bool get isActive => _timer?.isActive ?? false;

  void togglePlayState() {
    if (isActive) {
      _timer?.cancel();
      _timer = null;
      return;
    }
    _timer = Timer.periodic(_defaultDurationTick, (_) {
      final duration = value - _defaultDurationTick;
      if (duration.compareTo(Duration.zero) == 0 ||
          duration.compareTo(Duration.zero) == -1) {
        value = Duration.zero;
        _timer?.cancel();
        _timer = null;
        return;
      }
      value = duration;
    });
  }

  void reset() {
    _timer?.cancel();
    value = _startDuration;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
