import 'dart:async';

import 'package:flutter/foundation.dart';

const _defaultDuration = Duration(milliseconds: 400);

class Debouncer {
  Debouncer({this.duration = _defaultDuration});
  final Duration duration;
  Timer? _timer;

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
