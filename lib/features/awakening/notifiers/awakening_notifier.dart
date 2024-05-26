import 'dart:async';

import 'package:flutter/material.dart';

import '../../bluetooth/keep_mindful_device.dart';
import '../alarms_scheduler.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';

class AwakeningNotifier extends ChangeNotifier {
  AwakeningNotifier(AlarmsRepository alarmsRepository,
      AwakeningRepository awakeningRepository)
      : _alarmsRepository = alarmsRepository,
        _awakeningRepository = awakeningRepository;

  final AlarmsRepository _alarmsRepository;
  final AwakeningRepository _awakeningRepository;
  final _alarmScheduler = AlarmsScheduler();
  StreamSubscription<DateTime>? _alarmSchedulerSubscription;

  KeepMindfulDevice? _device;

  List<Alarm> _alarms = [];
  List<Alarm> get alarms => _alarms;

  bool _waitingForAlarmConfirm = false;

  bool get waitingForAlarmConfirm => _waitingForAlarmConfirm;

  void init() {
    _alarms = _alarmsRepository.getList();
    _sortAlarmsList();
    _alarmSchedulerSubscription =
        _alarmScheduler.events.listen(_onAlarmTriggered);
    _checkIfAlarmsTriggered();
  }

  void _checkIfAlarmsTriggered() {
    final now = DateTime.now();
    for (int pos = 0; pos < _alarms.length; pos++) {
      final alarm = alarms[pos];
      if (!alarm.isActive) {
        continue;
      }
      final alarmTime = alarms[pos].time;
      if (alarmTime.isBefore(now)) {
        _waitingForAlarmConfirm = true;
        notifyListeners();
        break;
      }
    }
  }

  void _onAlarmTriggered(DateTime time) {
    if (_waitingForAlarmConfirm) {
      return;
    }
    _waitingForAlarmConfirm = true;
    notifyListeners();
  }

  Future<void> onAlarmConfirmed() async {
    _waitingForAlarmConfirm = false;
    await _disableAlarmsTillNow();
  }

  Future<void> _disableAlarmsTillNow() async {
    final now = DateTime.now();
    for (int pos = 0; pos < _alarms.length; pos++) {
      final alarm = alarms[pos];
      if (!alarm.isActive) {
        continue;
      }
      final alarmTime = alarms[pos].time;
      final isBeforeNow = alarmTime.isBefore(now);
      if (isBeforeNow) {
        _disableAlarm(pos);
        break;
      }
    }
    await _awakeningRepository.setAlarmsDisabledUpdatedNow();
    await _sendAlarmsDisableTillNow();
  }

  Future<void> _disableAlarm(int pos) async {
    _alarmScheduler.removeAlarm(_alarms[pos].time);
    final alarm = _alarms[pos].copyWith(isActive: false);
    _alarms[pos] = alarm;
    await _alarmsRepository.update(alarm);
    await _awakeningRepository.setAlarmsUpdatedNow();
    notifyListeners();
  }

  Future<void> _activateAlarm(int pos) async {
    final alarm = _alarms[pos];
    DateTime alarmTime = alarm.time;
    if (alarmTime.isBefore(DateTime.now())) {
      alarmTime = alarmTime.add(const Duration(days: 1));
    }
    final newAlarm = alarm.copyWith(isActive: true, time: alarmTime);
    _alarmScheduler.addAlarm(alarmTime);
    await _alarmsRepository.update(newAlarm);
    await _awakeningRepository.setAlarmsUpdatedNow();
    _alarms[pos] = newAlarm;
    notifyListeners();
  }

  Future<void> setAlarmIsActive(int pos, bool isActive) async {
    if (isActive) {
      _activateAlarm(pos);
      return;
    }
    await _disableAlarm(pos);
    await _sendAlarmsList();
  }

  Future<void> addAlarm(Alarm alarm) async {
    _alarms.add(alarm);
    _alarmScheduler.addAlarm(alarm.time);
    await _alarmsRepository.add(alarm);
    _sortAlarmsList();
    notifyListeners();
    await _sendAlarmsList();
  }

  Future<void> removeAlarm(Alarm alarm) async {
    _alarmScheduler.removeAlarm(alarm.time);
    final pos = alarms.indexOf(alarm);
    _alarms.removeAt(pos);
    await _alarmsRepository.remove(alarm.createdAt);
    _sortAlarmsList();
    notifyListeners();
    await _sendAlarmsList();
  }

  Future<void> updateAlarm(int pos, Alarm alarm) async {
    if (alarm.isActive) {
      _alarmScheduler.updateAlarm(_alarms[pos].time, alarm.time);
    }
    _alarms[pos] = alarm;
    await _alarmsRepository.update(alarm);
    _sortAlarmsList();
    notifyListeners();
    await _sendAlarmsList();
  }

  void _sortAlarmsList() {
    if (alarms.length < 2) {
      return;
    }
    alarms.sort((alarm1, alarm2) => alarm1.time.compareTo(alarm2.time));
  }

  Future<void> _sendAlarmsList() async {
    try {
      final alarms = _alarms
          .where((element) => element.isActive)
          .map((e) => e.time)
          .toList();
      await _device!.setAlarms(alarms);
      await _awakeningRepository.setAlarmsSentNow();
    } catch (_) {}
  }

  Future<void> _sendAlarmsDisableTillNow() async {
    try {
      await _device?.disableAllAlarmsUntilNow();
      await _awakeningRepository.setAlarmsDisabledSentNow();
    } catch (_) {}
  }

  Future<void> resetAlarms() async {
    _alarms.clear();
    _alarmScheduler.dispose();
    await _alarmsRepository.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _alarmScheduler.dispose();
    _alarmSchedulerSubscription?.cancel();
    super.dispose();
  }

  Future<void> updateDevice(KeepMindfulDevice? newDevice) async {
    final oldDevice = _device;
    _device = newDevice;
    if (newDevice == null || oldDevice == null) {
      return;
    }
    if (oldDevice.remoteId != newDevice.remoteId) {
      await resetAlarms();
      await _awakeningRepository.clear();
      return;
    }
  }
}
