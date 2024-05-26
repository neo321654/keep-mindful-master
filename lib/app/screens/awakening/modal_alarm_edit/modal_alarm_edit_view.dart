import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../l10n/app_loc_extension.dart';
import '../../../../features/features.dart';
import '../../../shared/shared.dart';
import 'modal_alarm_edit_props.dart';
import 'modal_alarm_return_value.dart';

const _padding = 24.0;
const _hoursCount = 24;
const _minutesCount = 60;

class ModalAlarmEdit extends StatefulWidget {
  const ModalAlarmEdit({required this.props, super.key});

  final ModalAlarmEditProps props;

  @override
  State<ModalAlarmEdit> createState() => _ModalAlarmEditState();
}

class _ModalAlarmEditState extends State<ModalAlarmEdit> {
  late final FixedExtentScrollController _minutesController;
  late final FixedExtentScrollController _hoursController;
  late final AlarmEditNotifier _notifier;

  void _onSaveTapped(BuildContext context) {
    final updatedAlarm = _notifier.alarm;
    if (updatedAlarm == widget.props.alarm) {
      Navigator.of(context).pop();
      return;
    }
    final responseValue = ModalAlarmEditReturnValue(alarm: updatedAlarm);
    Navigator.of(context).pop(responseValue);
  }

  void _onRemoveTapped(BuildContext context) {
    final responseValue =
        ModalAlarmEditReturnValue(alarm: widget.props.alarm, removeAlarm: true);
    Navigator.of(context).pop(responseValue);
  }

  @override
  void initState() {
    super.initState();
    _notifier = AlarmEditNotifier();
    final alarmToUpdate = widget.props.alarm;

    _notifier.setAlarm(alarmToUpdate);

    _minutesController =
        FixedExtentScrollController(initialItem: alarmToUpdate.time.minute);
    _hoursController =
        FixedExtentScrollController(initialItem: alarmToUpdate.time.hour);
  }

  @override
  void dispose() {
    _minutesController.dispose();
    _hoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);

    final screenHeight = MediaQuery.of(context).size.height;

    return ModalBottomOrigin(
      props: ModalBottomOriginProps(
        height: screenHeight * 5 / 7,
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
                      controller: _hoursController,
                      count: _hoursCount,
                      title: loc.hours,
                      onChanged: _notifier.updateHours),
                ),
                const WidthSpacer(_padding),
                ListWheel(
                  props: ListWheelProps(
                      controller: _minutesController,
                      count: _minutesCount,
                      title: loc.minutes,
                      onChanged: _notifier.updateMinutes),
                ),
              ],
            ),
            const HeightSpacer(_padding),
            Button(
              props: ButtonProps(
                title: loc.awakeningAlarmSave,
                onPressed: () => _onSaveTapped(context),
                buttonStyle:
                    ButtonStyles.byType(theme, ButtonType.rectangleText),
              ),
            ),
            const HeightSpacer(_padding),
            Button(
              props: ButtonProps(
                title: loc.awakeningAlarmRemove,
                onPressed: () => _onRemoveTapped(context),
                buttonStyle:
                    ButtonStyles.byType(theme, ButtonType.borderlessTextError),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
