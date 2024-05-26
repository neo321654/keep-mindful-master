import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../l10n/app_loc_extension.dart';
import '../../../features/features.dart';
import '../../shared/shared.dart';

const _padding = 24.0;
const _hoursCount = 24;
const _minutesCount = 60;

class ModalAlarmAdd extends StatefulWidget {
  const ModalAlarmAdd({super.key});

  @override
  State<ModalAlarmAdd> createState() => _ModalAlarmAddState();
}

class _ModalAlarmAddState extends State<ModalAlarmAdd> {
  late final AlarmAddNotifier _notifier;

  void _onSaveTapped(BuildContext context) {
    Navigator.of(context).pop(_notifier.alarm);
  }

  @override
  void initState() {
    super.initState();
    _notifier = AlarmAddNotifier();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);

    final screenHeight = MediaQuery.of(context).size.height;

    return ModalBottomOrigin(
      props: ModalBottomOriginProps(
        height: screenHeight * 2 / 3,
        padding: const EdgeInsets.symmetric(vertical: _padding),
        child: Column(
          children: [
            Input(
              props: InputProps(
                textCapitalization: TextCapitalization.words,
                initialValue: _notifier.alarmName,
                onChanged: (val) => _notifier.alarmName = val,
                inputFormatters: [LengthLimitingTextInputFormatter(15)],
                style: InputStyles.byType(theme, InputType.noDecoration),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListWheel(
                  props: ListWheelProps(
                      count: _hoursCount,
                      title: loc.hours,
                      onChanged: _notifier.updateHours),
                ),
                const WidthSpacer(_padding),
                ListWheel(
                  props: ListWheelProps(
                      count: _minutesCount,
                      title: loc.minutes,
                      onChanged: _notifier.updateMinutes),
                ),
              ],
            ),
            const HeightSpacer(_padding),
            Button(
              props: ButtonProps(
                title: loc.awakeningAlarmAdd,
                onPressed: () => _onSaveTapped(context),
                buttonStyle:
                    ButtonStyles.byType(theme, ButtonType.rectangleText),
              ),
            )
          ],
        ),
      ),
    );
  }
}
