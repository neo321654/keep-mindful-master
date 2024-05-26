import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import '../../../features/features.dart';
import '../../../generated/assets.gen.dart';
import '../../../l10n/app_loc_extension.dart';
import '../../shared/shared.dart';
import 'controller_bar/controller_bar_props.dart';
import 'controller_bar/controller_bar_view.dart';
import 'sound_switcher/sound_switcher.dart';

const _topPadding = 20.0;
const _bottomPadding = 20.0;
const _textInputMinWidth = 100.0;
const _paddingBetweenElements = 30.0;
const _sliderHorizontalPadding = 35.0;
const _sliderMaxValue = 240.0;
const _sliderDivisions = 17;
const _soundSwitcherHorizontalPadding = 50.0;
const _barsAnimationDuration = Duration(milliseconds: 400);
const _barsMaxNumber = 10;

@RoutePage()
class MetronomeScreen extends StatefulWidget {
  const MetronomeScreen({super.key});

  @override
  State<MetronomeScreen> createState() => _MetronomeScreenState();
}

class _MetronomeScreenState extends State<MetronomeScreen> {
  final _notifier = GetIt.instance<MetronomeNotifier>();
  final _bleDeviceNotifier = GetIt.instance<BluetoothDeviceStateNotifier>();

  late final TextEditingController _inputController;
  late final FixedExtentScrollController _barsController;

  void _animateToPreviousBarsNumber() {
    final currentNumberOfBars = _notifier.numberOfBars;
    int numberOfBars = currentNumberOfBars - 1;
    if (numberOfBars < 0) {
      numberOfBars = _barsMaxNumber - 1;
    }
    _barsController.animateToItem(numberOfBars,
        duration: _barsAnimationDuration, curve: Curves.easeInOut);
  }

  void _animateToNextBarsNumber() {
    final currentNumberOfBars = _notifier.numberOfBars;
    int numberOfBars = currentNumberOfBars + 1;
    if (numberOfBars >= _barsMaxNumber) {
      numberOfBars = 0;
    }
    _barsController.animateToItem(numberOfBars,
        duration: _barsAnimationDuration, curve: Curves.easeInOut);
  }

  void _onDeviceUpdated() {
    _notifier.updateDevice(_bleDeviceNotifier.device);
  }

  @override
  void initState() {
    super.initState();
    _notifier.updateDevice(_bleDeviceNotifier.device);
    _bleDeviceNotifier.addListener(_onDeviceUpdated);
    _notifier.init();
    _inputController =
        TextEditingController(text: _notifier.bpm.toStringAsFixed(0));
    _barsController =
        FixedExtentScrollController(initialItem: _notifier.numberOfBars);
  }

  @override
  void dispose() {
    _bleDeviceNotifier.removeListener(_onDeviceUpdated);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = context.loc;

    return Semantics(
      label: loc.metronomeTitle,
      child: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: _topPadding, bottom: _bottomPadding),
        child: SeparatedColumn(
          separatorBuilder: (_, __) =>
              const HeightSpacer(_paddingBetweenElements),
          children: [
            Text(
              loc.metronomePace,
              style: theme.textTheme.displaySmall
                  ?.copyWith(color: theme.colorScheme.onBackground),
            ),
            Input(
              props: InputProps(
                keyboardType: TextInputType.number,
                controller: _inputController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  const RangeInputFormatter(min: 0, max: _sliderMaxValue)
                ],
                onChanged: (val) =>
                    _notifier.updateBpm(double.tryParse(val) ?? 0.0),
                minWidth: _textInputMinWidth,
                style: InputStyles.byType(
                  theme,
                  InputType.decoratedTextIcon,
                ),
                trailingIcon: Assets.icons.metronomeTempoBeat,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: _sliderHorizontalPadding),
              child: ListenableBuilder(
                  listenable: _notifier,
                  builder: (_, __) {
                    return AppSlider(
                      props: AppSliderProps(
                          max: _sliderMaxValue,
                          value: _notifier.bpm,
                          onChange: (val) {
                            _inputController.text = val.toStringAsFixed(0);
                            _notifier.updateBpm(val);
                          },
                          divisions: _sliderDivisions),
                    );
                  }),
            ),
            ListWheel(
              props: ListWheelProps(
                  direction: Axis.horizontal,
                  count: _barsMaxNumber,
                  title: loc.metronomeNumberOfBars,
                  controller: _barsController,
                  startFromZero: false,
                  onChanged: _notifier.updateNumberOfBars),
            ),
            ListenableBuilder(
                listenable: _notifier,
                builder: (_, __) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: _soundSwitcherHorizontalPadding),
                    child: SoundSwitcher(
                      props: SoundSwitcherProps(
                          onChanged: _notifier.updateBarSkipSwither,
                          isSelected: _notifier.barSkipSwitcherEnabled),
                    ),
                  );
                }),
            ListenableBuilder(
                listenable: _notifier,
                builder: (_, __) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: _soundSwitcherHorizontalPadding),
                    child: ControllerBar(
                      props: ControllerBarProps(
                        isActive: _notifier.isActive,
                        onStartPressed: _notifier.updateIsActive,
                        onPreviousPressed: _animateToPreviousBarsNumber,
                        onNextPressed: _animateToNextBarsNumber,
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
