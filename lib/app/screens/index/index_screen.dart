import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide BottomNavigationBar;
import 'package:get_it/get_it.dart';

import '../../../features/features.dart';
import '../../../l10n/app_loc_extension.dart';
import '../../router/app_router.gr.dart';
import '../../shared/shared.dart';
import 'alarm_disable_mode_handler.dart';

const _childRoutesValues = ['timer', 'metronome', 'awakening'];

@RoutePage()
class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  final _bleDeviceNotifier = GetIt.instance<BluetoothDeviceStateNotifier>();
  final _timerNotifier = GetIt.instance<TimerNotifier>();
  final _intervalNotifier = GetIt.instance<IntervalNotifier>();
  final _durationNotifier = GetIt.instance<DurationNotifier>();
  final _awakeningNotifier = GetIt.instance<AwakeningNotifier>();
  final _wakeUpModeNotifier = GetIt.instance<WakeUpModeNotifier>();
  final _qrService = GetIt.instance<AlarmDisableQrCodeService>();

  final _metronomeSynchronizer = GetIt.instance<MetronomeSynchronizer>();
  final _timerSynchronizer = GetIt.instance<TimerSynchronizer>();
  final _intensitySynchronizer = GetIt.instance<IntensitySynchronizer>();
  final _awakeningSynchronizer = GetIt.instance<AwakeningSynchronizer>();
  final _languageSynchronizer = GetIt.instance<AppLanguageSynchronizer>();

  late final AlarmDisableHandler _alarmDisableModeHandler;

  Future<bool?> _showQrScanModal(BuildContext context,
      {void Function()? tryNext}) {
    return showModalBottomSheet<bool?>(
        context: context,
        enableDrag: false,
        isScrollControlled: true,
        useRootNavigator: true,
        isDismissible: false,
        builder: (_) {
          return ModalAlarmDisableQrScan(
            props: ModalAlarmDisabelQrScanProps(
                qr: _qrService.getQr()!, onTryAnotherWayPressed: tryNext),
          );
        });
  }

  Future<bool?> _showMathExcerciseModal(BuildContext context,
      {void Function()? tryNext}) {
    return showModalBottomSheet<bool?>(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        enableDrag: false,
        isDismissible: false,
        builder: (_) {
          return ModalAlarmDisableQuiz(
            props: ModalAlarmDisableQuizProps(onTryAnotherWayPressed: tryNext),
          );
        });
  }

  Future<bool?> _showCaptchaModal(BuildContext context,
      {void Function()? tryNext}) {
    return showModalBottomSheet<bool?>(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        enableDrag: false,
        isDismissible: false,
        builder: (_) {
          return ModalAlarmDisableCaptcha(
            props:
                ModalAlarmDisableCaptchaProps(onTryAnotherWayPressed: tryNext),
          );
        });
  }

  void _openNextDialog() =>
      _alarmDisableModeHandler.openDialog(_wakeUpModeNotifier.availableModes);

  void _handleAlarmTrigger() => _alarmDisableModeHandler.onAlarmTriggered(
      isWaitingForConfirm: _awakeningNotifier.waitingForAlarmConfirm,
      modes: _wakeUpModeNotifier.availableModes);

  void _showDialog(AlarmDisableMode mode, bool nextEnabled) {
    switch (mode) {
      case AlarmDisableMode.qrCode:
        _showQrScanModal(context, tryNext: nextEnabled ? _openNextDialog : null)
            .then(_alarmDisableModeHandler.onModalClosed);
        break;
      case AlarmDisableMode.mathQuiz:
        _showMathExcerciseModal(context,
                tryNext: nextEnabled ? _openNextDialog : null)
            .then(_alarmDisableModeHandler.onModalClosed);
        break;
      case AlarmDisableMode.captcha:
        _showCaptchaModal(context,
                tryNext: nextEnabled ? _openNextDialog : null)
            .then(_alarmDisableModeHandler.onModalClosed);
        break;
    }
  }

  void _onDeviceUpdated() {
    final device = _bleDeviceNotifier.device;
    _timerNotifier.updateDevice(device);
    _durationNotifier.updateDevice(device);
    _intervalNotifier.updateDevice(device);
    _awakeningNotifier.updateDevice(device);

    _timerSynchronizer.makeSync(device);
    _intensitySynchronizer.makeSync(device);
    _metronomeSynchronizer.makeSync(device);
    _awakeningSynchronizer.makeSync(device);
    _languageSynchronizer.makeSync(device);
  }

  @override
  void initState() {
    super.initState();
    _bleDeviceNotifier.addListener(_onDeviceUpdated);
    _alarmDisableModeHandler = AlarmDisableHandler(
      onAlarmConfirmed: _awakeningNotifier.onAlarmConfirmed,
      showDialog: _showDialog,
    );
    _awakeningNotifier.addListener(_handleAlarmTrigger);

    if (_awakeningNotifier.waitingForAlarmConfirm) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _handleAlarmTrigger());
    }
  }

  @override
  void dispose() {
    _bleDeviceNotifier.removeListener(_onDeviceUpdated);
    _awakeningNotifier.removeListener(_handleAlarmTrigger);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;

    final topBarItems = [
      DropdownItemProps(title: loc.timerTitle, value: _childRoutesValues.first),
      DropdownItemProps(
          title: loc.metronomeTitle, value: _childRoutesValues[1]),
      DropdownItemProps(
          title: loc.awakeningTitle, value: _childRoutesValues.last),
    ];

    return AutoTabsRouter(
      homeIndex: 0,
      routes: [
        IndexTimerScreenRoute(),
        IndexMetronomeScreenRoute(),
        IndexAwakeningScreenRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: MainTopBar(
            props: MainTopBarProps(
                menuItems: topBarItems,
                selectedMenuItemPosition: tabsRouter.activeIndex,
                onMenuItemPressed: tabsRouter.setActiveIndex),
          ),
          body: child,
        );
      },
    );
  }
}
