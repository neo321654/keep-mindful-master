import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../features/features.dart';
import '../../../generated/assets.gen.dart';
import '../../../l10n/app_loc_extension.dart';
import '../../shared/shared.dart';
import 'alarm_item/alarm_item.dart';
import 'modal_alarm_add.dart';
import 'modal_alarm_edit/modal_alarm_edit.dart';

const _addButtonBottomPadding = 50.0;
const _topPadding = 20.0;
const _paddingBetweenElements = 18.0;
const _listPadding = EdgeInsets.symmetric(horizontal: 31.0, vertical: 24.0);

@RoutePage()
class AwakeningScreen extends StatefulWidget {
  const AwakeningScreen({super.key});

  @override
  State<AwakeningScreen> createState() => _AwakeningScreenState();
}

class _AwakeningScreenState extends State<AwakeningScreen> {
  final _qrShownService = GetIt.instance<AlarmDisableQrShownService>();
  final _notifier = GetIt.instance<AwakeningNotifier>();

  void _onAddAlarmPressed(BuildContext context) {
    showModalBottomSheet<Alarm?>(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return const ModalAlarmAdd();
        }).then(_handleOnAlarmAdded);
  }

  Future<void> _showQrModal(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return const ModalAlarmDisableQr();
        });
  }

  void _onAlarmPressed(BuildContext context, int pos) {
    showModalBottomSheet<ModalAlarmEditReturnValue?>(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return ModalAlarmEdit(
            props: ModalAlarmEditProps(
              alarm: _notifier.alarms[pos],
            ),
          );
        }).then((val) => _handleOnAlarmEdited(pos, val));
  }

  void _handleOnAlarmAdded(Alarm? alarm) {
    if (alarm != null) {
      _notifier.addAlarm(alarm);
    }
  }

  void _handleOnAlarmEdited(int pos, ModalAlarmEditReturnValue? returnValue) {
    if (returnValue == null) {
      return;
    }

    if (returnValue.removeAlarm) {
      _notifier.removeAlarm(returnValue.alarm);
      return;
    }

    _notifier.updateAlarm(pos, returnValue.alarm);
  }

  void _checkIfModalQrWasShown() {
    if (_qrShownService.wasShown()) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showQrModal(context).then((_) => _qrShownService.markAsShown());
    });
  }

  @override
  void initState() {
    super.initState();
    _checkIfModalQrWasShown();
  }

  @override
  void dispose() {
    super.dispose();
    _notifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);
    return Semantics(
      label: loc.awakeningAlarmClocks,
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                const HeightSpacer(_topPadding),
                Text(
                  loc.awakeningAlarmClocks,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                Expanded(
                  child: ListenableBuilder(
                      listenable: _notifier,
                      builder: (_, __) {
                        if (_notifier.alarms.isEmpty) {
                          return const SizedBox();
                        }
                        return ListView.separated(
                          padding: _listPadding,
                          itemBuilder: (_, pos) {
                            final alarm = _notifier.alarms[pos];

                            return AlarmItem(
                              props: AlarmItemProps(
                                  name: alarm.name,
                                  time: alarm.time,
                                  isActive: alarm.isActive,
                                  onActivatePressed: (val) =>
                                      _notifier.setAlarmIsActive(pos, val),
                                  onPressed: () =>
                                      _onAlarmPressed(context, pos)),
                            );
                          },
                          itemCount: _notifier.alarms.length,
                          separatorBuilder: (_, __) =>
                              const HeightSpacer(_paddingBetweenElements),
                        );
                      }),
                ),
              ],
            ),
          ),
          Align(
            child: ListenableBuilder(
                listenable: _notifier,
                builder: (_, __) {
                  if (_notifier.alarms.isNotEmpty) {
                    return const SizedBox();
                  }

                  return Text(
                    loc.awakeningAlarmsEmpty,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onBackground,
                        fontWeight: FontWeight.w300),
                  );
                }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: _addButtonBottomPadding),
              child: Button(
                props: ButtonProps(
                  onPressed: () => _onAddAlarmPressed(context),
                  leftIcon: Assets.icons.neoAdd,
                  buttonStyle: ButtonStyles.byType(
                    theme,
                    ButtonType.circleIconLarge,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
