import 'package:auto_route/auto_route.dart';
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
class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final _timerNotifier = GetIt.instance<TimerNotifier>();
  final _durationNotifier = GetIt.instance<DurationNotifier>();
  final _intervalNotifier = GetIt.instance<IntervalNotifier>();

  late final FixedExtentScrollController _hoursController;
  late final FixedExtentScrollController _minutesController;
  late final FixedExtentScrollController _secondsController;

  void _navigateToDuration(BuildContext context) {
    final tabsRouter = AutoTabsRouter.of(context);
    tabsRouter.setActiveIndex(1);
  }

  void _showIntervalModal(BuildContext context) {
    showModalBottomSheet<Duration?>(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return const ModalInterval();
        });
  }

  void _resetDuration() {
    if (_timerNotifier.isCountdownActive) {
      _durationNotifier.resetDuration();
      _intervalNotifier.resetInterval();
    }
    _timerNotifier.resetDuration();
  }

  void _updateCurrentTime() {
    if (!_timerNotifier.isCountdownActive) {
      return;
    }
    final currentDuration = _timerNotifier.duration;
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
    if (_timerNotifier.isCountdownActive) {
      return;
    }
    final updatedDuration = _timerNotifier.duration
        .copyWith(hours: hours, minutes: minutes, seconds: seconds);
    _timerNotifier.setDuration(updatedDuration);
  }

  void _toggleTimerCountdown() {
    if (_timerNotifier.isCountdownActive) {
      _timerNotifier.setCountdownActive(false);
      _durationNotifier.setCountdownActive(false);
      return;
    }
    _timerNotifier.setCountdownActive(true);
    if (!_timerNotifier.isCountdownActive) {
      return;
    }
    if (_timerNotifier.duration.compareTo(_durationNotifier.duration) < 0) {
      _durationNotifier.setCountdownActive(true);
      return;
    }
    _durationNotifier.resetDuration();
    _intervalNotifier.resetInterval();
  }

  @override
  void initState() {
    super.initState();
    final duration = _timerNotifier.duration;
    _hoursController =
        FixedExtentScrollController(initialItem: duration.inHours);
    _minutesController = FixedExtentScrollController(
        initialItem: duration.inMinutes.remainder(60));
    _secondsController = FixedExtentScrollController(
        initialItem: duration.inSeconds.remainder(60));
    _timerNotifier.addListener(_updateCurrentTime);
  }

  @override
  void dispose() {
    _hoursController.dispose();
    _minutesController.dispose();
    _secondsController.dispose();
    _timerNotifier.removeListener(_updateCurrentTime);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);
    return Semantics(
      label: loc.timerTitle,
      focused: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const HeightSpacer(_topPadding),
            Text(
              loc.timerTitle,
              style: theme.textTheme.displaySmall
                  ?.copyWith(color: theme.colorScheme.onBackground),
            ),
            const HeightSpacer(_paddingBetweenElements),
            ListenableBuilder(
                listenable: _timerNotifier,
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
                            enabled: !_timerNotifier.isCountdownActive,
                            onChanged: (hours) => _onTimerChange(hours: hours)),
                      ),
                      ListWheel(
                        props: ListWheelProps(
                            controller: _minutesController,
                            count: _minutesCount,
                            title: loc.minutes,
                            enabled: !_timerNotifier.isCountdownActive,
                            onChanged: (minutes) =>
                                _onTimerChange(minutes: minutes)),
                      ),
                      ListWheel(
                        props: ListWheelProps(
                            controller: _secondsController,
                            count: _secondsCount,
                            title: loc.seconds,
                            enabled: !_timerNotifier.isCountdownActive,
                            onChanged: (seconds) =>
                                _onTimerChange(seconds: seconds)),
                      ),
                    ],
                  );
                }),
            const HeightSpacer(_paddingBetweenElements),
            ListenableBuilder(
                listenable: _timerNotifier,
                builder: (_, __) {
                  final isStartTimerActive = _timerNotifier.isCountdownActive;
                  return TimeActionsBar(
                    props: TimeActionsBarProps(
                        isActive: isStartTimerActive,
                        onStopPressed: _resetDuration,
                        onIntervalPressed: () => _showIntervalModal(context),
                        onStartPressed: _toggleTimerCountdown),
                  );
                }),
            const HeightSpacer(_paddingBetweenElements),
            Button(
              props: ButtonProps(
                title: loc.timerSetDuration,
                onPressed: () => _navigateToDuration(context),
                buttonStyle: ButtonStyles.byType(
                  theme,
                  ButtonType.rectangleText,
                ),
              ),
            ),
            const HeightSpacer(_bottomPadding),
          ],
        ),
      ),
    );
  }
}
