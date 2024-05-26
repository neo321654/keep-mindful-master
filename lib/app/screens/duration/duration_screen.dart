import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../features/features.dart';
import '../../../l10n/app_loc_extension.dart';
import '../../shared/shared.dart';

const _topPadding = 20.0;
const _bottomPadding = 20.0;
const _paddingBetweenElements = 24.0;

const _hoursCount = 24;
const _minutesCount = 60;
const _secondsCount = 60;
const _listWheelAnimationDuration = Duration(milliseconds: 400);

@RoutePage()
class DurationScreen extends StatefulWidget {
  const DurationScreen({Key? key}) : super(key: key);

  @override
  State<DurationScreen> createState() => _DurationScreenState();
}

class _DurationScreenState extends State<DurationScreen> {
  final _durationNotifier = GetIt.instance<DurationNotifier>();
  final _timerNotifier = GetIt.instance<TimerNotifier>();

  late final FixedExtentScrollController _hoursController;
  late final FixedExtentScrollController _minutesController;
  late final FixedExtentScrollController _secondsController;

  void _showIntervalModal(BuildContext context) {
    showModalBottomSheet<Duration?>(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return const ModalInterval();
        });
  }

  void _toggleDurationCountdown() {
    final isCountdownActive = _durationNotifier.isCountdownActive;
    if (isCountdownActive) {
      _durationNotifier.setCountdownActive(false);
      if (_timerNotifier.isCountdownActive) {
        _timerNotifier.setCountdownActive(false);
      }
      return;
    }
    if (_timerNotifier.duration.compareTo(_durationNotifier.duration) != -1) {
      // TODO: Show to user that finish time can't be less or equal to start time
      return;
    }
    _durationNotifier.setCountdownActive(true);
    _timerNotifier.setCountdownActive(true);
  }

  void _updateCurrentTime() {
    if (!_durationNotifier.isCountdownActive) {
      return;
    }
    final currentDuration = _durationNotifier.duration;
    final hours = currentDuration.inHours;
    final minutes = currentDuration.inMinutes.remainder(60);
    final seconds = currentDuration.inSeconds.remainder(60);
    if (hours != _hoursController.selectedItem) {
      _hoursController.animateToItem(hours,
          duration: _listWheelAnimationDuration, curve: Curves.easeInOut);
    }
    if (minutes != _minutesController.selectedItem) {
      _minutesController.animateToItem(minutes,
          duration: _listWheelAnimationDuration, curve: Curves.easeInOut);
    }
    if (seconds != _secondsController.selectedItem) {
      _secondsController.animateToItem(seconds,
          duration: _listWheelAnimationDuration, curve: Curves.easeInOut);
    }
  }

  void _onTimerChange({int? hours, int? minutes, int? seconds}) {
    if (_durationNotifier.isCountdownActive) {
      return;
    }
    final updatedDuration = _durationNotifier.duration
        .copyWith(hours: hours, minutes: minutes, seconds: seconds);
    _durationNotifier.setDuration(updatedDuration);
  }

  @override
  void initState() {
    super.initState();
    final duration = _durationNotifier.duration;
    _hoursController =
        FixedExtentScrollController(initialItem: duration.inHours);
    _minutesController = FixedExtentScrollController(
        initialItem: duration.inMinutes.remainder(60));
    _secondsController = FixedExtentScrollController(
        initialItem: duration.inSeconds.remainder(60));
    _durationNotifier.addListener(_updateCurrentTime);
  }

  @override
  void dispose() {
    _hoursController.dispose();
    _minutesController.dispose();
    _secondsController.dispose();
    _durationNotifier.removeListener(_updateCurrentTime);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);
    return Semantics(
      label: loc.durationTitle,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const HeightSpacer(_topPadding),
            Text(
              loc.durationTitle,
              style: theme.textTheme.displaySmall
                  ?.copyWith(color: theme.colorScheme.onBackground),
            ),
            const HeightSpacer(_paddingBetweenElements),
            ListenableBuilder(
                listenable: _durationNotifier,
                builder: (_, __) {
                  return SeparatedRow(
                    separatorBuilder: (_, __) =>
                        const WidthSpacer(_paddingBetweenElements),
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListWheel(
                        props: ListWheelProps(
                          controller: _hoursController,
                          count: _hoursCount,
                          title: loc.hours,
                          enabled: !_durationNotifier.isCountdownActive,
                          onChanged: (hours) => _onTimerChange(hours: hours),
                        ),
                      ),
                      ListWheel(
                        props: ListWheelProps(
                            controller: _minutesController,
                            count: _minutesCount,
                            title: loc.minutes,
                            enabled: !_durationNotifier.isCountdownActive,
                            onChanged: (minutes) =>
                                _onTimerChange(minutes: minutes)),
                      ),
                      ListWheel(
                        props: ListWheelProps(
                          controller: _secondsController,
                          count: _secondsCount,
                          title: loc.seconds,
                          enabled: !_durationNotifier.isCountdownActive,
                          onChanged: (seconds) =>
                              _onTimerChange(seconds: seconds),
                        ),
                      ),
                    ],
                  );
                }),
            const HeightSpacer(_paddingBetweenElements),
            ListenableBuilder(
                listenable: _durationNotifier,
                builder: (_, __) {
                  final isEndTimerActive = _durationNotifier.isCountdownActive;
                  return TimeActionsBar(
                    props: TimeActionsBarProps(
                        isActive: isEndTimerActive,
                        onStopPressed: _durationNotifier.resetDuration,
                        onIntervalPressed: () => _showIntervalModal(context),
                        onStartPressed: _toggleDurationCountdown),
                  );
                }),
            const HeightSpacer(_bottomPadding),
          ],
        ),
      ),
    );
  }
}
