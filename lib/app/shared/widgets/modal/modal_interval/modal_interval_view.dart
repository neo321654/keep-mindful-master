import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../../features/features.dart';
import '../../../../../l10n/app_loc_extension.dart';
import '../../../shared.dart';
import 'minutes_button/minutes_button.dart';

const _padding = 24.0;
const _minutesCount = 61;
const _secondsCount = 60;
const _paddingBetweenButtons = 8.0;
const _minuteSteps = [5, 10, 30, 45, 60];
const _scrollAnimationDuration = Duration(milliseconds: 800);

class ModalInterval extends StatefulWidget {
  const ModalInterval({super.key});

  @override
  State<ModalInterval> createState() => _ModalIntervalState();
}

class _ModalIntervalState extends State<ModalInterval> {
  late final List<Widget> minutes;
  late final FixedExtentScrollController _minutesController;
  late final FixedExtentScrollController _secondsController;

  final _intervalNotifier = GetIt.instance<IntervalNotifier>();

  Future<void> _onSaveTapped(BuildContext context) async {
    await _intervalNotifier.saveInterval();
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void _updateInterval({int? minutes, int? seconds}) {
    final interval = _intervalNotifier.interval;
    _intervalNotifier
        .setInterval(interval.copyWith(minutes: minutes, seconds: seconds));
  }

  void _onMinTapped(int min) {
    _minutesController.animateToItem(min,
        duration: _scrollAnimationDuration, curve: Curves.easeInOut);
  }

  void _initControllers() {
    final initialDuration = _intervalNotifier.interval;
    final minutes = initialDuration.inMinutes.remainder(60);
    final seconds = initialDuration.inSeconds.remainder(60);
    _minutesController = FixedExtentScrollController(initialItem: minutes);
    _secondsController = FixedExtentScrollController(initialItem: seconds);
  }

  @override
  void initState() {
    super.initState();
    _intervalNotifier.getInitialInterval();
    minutes = _minuteSteps
        .map((min) => MinutesButton(
            props: MinutesButtonProps(minutes: min, onPressed: _onMinTapped)))
        .toList();
    _initControllers();
  }

  @override
  void dispose() {
    _minutesController.dispose();
    _secondsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);

    final screenHeight = MediaQuery.of(context).size.height;

    return ModalBottomOrigin(
        props: ModalBottomOriginProps(
            padding: const EdgeInsets.symmetric(vertical: _padding),
            child: SeparatedColumn(
              separatorBuilder: (_, __) => const HeightSpacer(_padding),
              children: [
                Text(
                  loc.intervalTitle,
                  style: theme.textTheme.headlineLarge?.copyWith(
                      color: theme.colorScheme.onBackground,
                      fontWeight: FontWeight.w300),
                ),
                SeparatedRow(
                  separatorBuilder: (_, __) => const WidthSpacer(_padding),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListWheel(
                      props: ListWheelProps(
                          controller: _minutesController,
                          count: _minutesCount,
                          title: loc.minutes,
                          onChanged: (min) => _updateInterval(minutes: min)),
                    ),
                    ListWheel(
                      props: ListWheelProps(
                          controller: _secondsController,
                          count: _secondsCount,
                          title: loc.seconds,
                          onChanged: (sec) => _updateInterval(seconds: sec)),
                    ),
                  ],
                ),
                SeparatedRow(
                    mainAxisAlignment: MainAxisAlignment.center,
                    separatorBuilder: (_, __) =>
                        const WidthSpacer(_paddingBetweenButtons),
                    children: minutes),
                Button(
                  props: ButtonProps(
                    title: loc.intervalSave,
                    onPressed: () => _onSaveTapped(context),
                    buttonStyle:
                        ButtonStyles.byType(theme, ButtonType.rectangleText),
                  ),
                )
              ],
            ),
            height: screenHeight * 3 / 4));
  }
}
