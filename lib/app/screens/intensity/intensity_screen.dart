import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../features/features.dart';
import '../../../generated/assets.gen.dart';
import '../../../l10n/app_loc_extension.dart';
import '../../shared/shared.dart';
import 'intensity_indicator/intensity_indicator.dart';

const _paddingBetweenElements = 38.0;
const _sliderHorizontalPadding = 35.0;
const _sliderDivisions = 17;
const _paddingTop = 24.0;
const _paddingBottom = 30.0;
const _hintHorizontalPadding = 20.0;

@RoutePage()
class IntensityScreen extends StatefulWidget {
  const IntensityScreen({required this.mode, Key? key}) : super(key: key);

  final IntensityMode mode;

  @override
  State<IntensityScreen> createState() => _IntensityScreenState();
}

class _IntensityScreenState extends State<IntensityScreen> {
  final _intensityNotifier = GetIt.instance<IntensityNotifier>();
  final _deviceNotifier = GetIt.instance<BluetoothDeviceStateNotifier>();

  void _deviceUpdated() {
    _intensityNotifier.updateDevice(_deviceNotifier.device);
  }

  @override
  void initState() {
    super.initState();
    _intensityNotifier.setMode(widget.mode);
    _intensityNotifier.updateDevice(_deviceNotifier.device);
    _deviceNotifier.addListener(_deviceUpdated);
  }

  @override
  void dispose() {
    _intensityNotifier.dispose();
    _deviceNotifier.removeListener(_deviceUpdated);
    super.dispose();
  }

  void _updateIntensityType(String selectedType) {
    final type = NotificationType.values
        .firstWhere((element) => element.name == selectedType);
    _intensityNotifier.updateSelectedType(type);
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);

    final notifyTypes = [
      SelectorItemProps(
          title: loc.intensityVibration,
          value: NotificationType.vibration.name),
      SelectorItemProps(
          title: loc.intensityDischarge, value: NotificationType.shock.name),
    ];

    return Semantics(
      label: loc.intensity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: _paddingTop, bottom: _paddingBottom),
          child: SeparatedColumn(
            separatorBuilder: (_, __) =>
                const HeightSpacer(_paddingBetweenElements),
            children: [
              Text(
                loc.intensity,
                style: theme.textTheme.displaySmall?.copyWith(
                  color: theme.colorScheme.onBackground,
                ),
              ),
              ListenableBuilder(
                  listenable: _intensityNotifier,
                  builder: (_, __) {
                    return Column(
                      children: [
                        Selector(
                          props: SelectorProps(
                              items: notifyTypes,
                              groupValue:
                                  _intensityNotifier.selectedNotifyType.name,
                              onPressed: _updateIntensityType),
                        ),
                        const HeightSpacer(_paddingBetweenElements),
                        IntensityIndicator(
                          props: IntensityIndicatorProps(
                              intensity: _intensityNotifier.intensity),
                        ),
                      ],
                    );
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: _sliderHorizontalPadding),
                child: ListenableBuilder(
                  listenable: _intensityNotifier,
                  builder: (_, __) => AppSlider(
                    props: AppSliderProps(
                        value: _intensityNotifier.intensity,
                        onChange: _intensityNotifier.updateIntensity,
                        divisions: _sliderDivisions),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: _hintHorizontalPadding),
                child: Text(
                  loc.intensityCheckSelectedIntensity,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge
                      ?.copyWith(color: theme.colorScheme.onBackground),
                ),
              ),
              Button(
                props: ButtonProps(
                  semanticsLabel: loc.intensityCheckSelectedIntensity,
                  onPressed: _intensityNotifier.checkIntensity,
                  leftIcon: Assets.icons.neoFlash,
                  buttonStyle: ButtonStyles.byType(
                    theme,
                    ButtonType.circleIconLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
