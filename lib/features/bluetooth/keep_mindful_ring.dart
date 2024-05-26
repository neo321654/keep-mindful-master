import 'dart:async';
import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'constants/constants.dart';
import 'keep_mindful_device.dart';

class KeepMindfulRing extends KeepMindfulDevice {
  KeepMindfulRing(
      {required this.deviceRemoteId,
      this.serviceUuid = BaseGuids.service,
      this.characteristicReadUuid = BaseGuids.readCharacteristic,
      this.characteristicWriteUuid = BaseGuids.writeCharacteristic})
      : _bluetoothDevice = BluetoothDevice.fromId(deviceRemoteId) {
    _connectionStateSubscription =
        _bluetoothDevice.connectionState.listen(_updateConnectionState);
  }

  final BluetoothDevice _bluetoothDevice;

  final String deviceRemoteId;
  final String serviceUuid;
  final String characteristicReadUuid;
  final String characteristicWriteUuid;

  BluetoothCharacteristic? _characteristicRead;
  BluetoothCharacteristic? _characteristicWrite;

  StreamSubscription<BluetoothConnectionState>? _connectionStateSubscription;

  final StreamController<int> _batteryLevelStreamController =
      StreamController.broadcast();
  final StreamController<bool> _deviceResetStreamController =
      StreamController.broadcast();
  final StreamController<int> _firmwareVersionNumberStreamController =
      StreamController.broadcast();
  final StreamController<bool> _deviceFoundStreamController =
      StreamController.broadcast();
  final StreamController<BleDeviceConnectionState>
      _deviceConnectionStateController = StreamController.broadcast();

  @override
  Stream<BleDeviceConnectionState> get connectionState =>
      _deviceConnectionStateController.stream;

  @override
  bool get isConnected => _bluetoothDevice.isConnected;

  @override
  Stream<int> get batteryLevel => _batteryLevelStreamController.stream;

  @override
  Stream<bool> get deviceReset => _deviceResetStreamController.stream;

  @override
  Stream<int> get firmwareVersionNumber =>
      _firmwareVersionNumberStreamController.stream;

  @override
  Stream<bool> get deviceFound => _deviceFoundStreamController.stream;

  @override
  String get remoteId => deviceRemoteId;

  bool _delayDisconnectionState = false;

  Future<void> _subscribeToDeviceResponse() async {
    final services = await _bluetoothDevice.discoverServices();
    _attachToService(services);
    await _characteristicRead?.setNotifyValue(true);
    _deviceConnectionStateController.add(BleDeviceConnectionState.connected);
    final responseSubscription =
        _characteristicRead?.onValueReceived.listen(_readCommand);
    if (responseSubscription != null) {
      _bluetoothDevice.cancelWhenDisconnected(responseSubscription);
    }
  }

  void _attachToService(List<BluetoothService> services) {
    final service = services.singleWhere(
      (element) => element.uuid.str == serviceUuid,
    );

    for (final characteristic in service.characteristics) {
      if (characteristic.uuid.str == characteristicReadUuid) {
        _characteristicRead = characteristic;
        continue;
      }
      if (characteristic.uuid.str == characteristicWriteUuid) {
        _characteristicWrite = characteristic;
      }
    }
  }

  void _updateConnectionState(BluetoothConnectionState state) {
    final connected = state == BluetoothConnectionState.connected;
    if (!connected) {
      if (_delayDisconnectionState) {
        _delayDisconnectionState = false;
        return;
      }
      _deviceConnectionStateController
          .add(BleDeviceConnectionState.disconnected);
      return;
    }
    _subscribeToDeviceResponse();
  }

  String _calculateChecksum(String hexString) {
    int sum = 0;
    for (int pos = 0; pos <= hexString.length - 1; pos += 2) {
      final value = int.parse(hexString.substring(pos, pos + 2), radix: 16);
      sum += value;
    }
    final result = sum & 255;
    return result.toRadixString(16).padLeft(2, '0');
  }

  String _convertToCommand(
      {required String command, required String key, String? value}) {
    final stringBuffer = StringBuffer('AA');
    stringBuffer.write(command);
    stringBuffer.write(key);
    if (value != null) {
      final bytesLength = (value.length ~/ 2).toRadixString(16).padLeft(2, '0');
      stringBuffer.write(bytesLength);
      stringBuffer.write(value);
      stringBuffer.write(_calculateChecksum(value));
    } else {
      stringBuffer.write('00');
      stringBuffer.write('00');
    }
    stringBuffer.write('EF');
    return stringBuffer.toString();
  }

  Future<void> _writeCommand(String command) async {
    final listInt = hex.decode(command);
    await _characteristicWrite?.write(listInt);
  }

  void _handleFirmwareVersionCommand(List<int> bytes) {
    _firmwareVersionNumberStreamController.add(bytes[5]);
  }

  // Returns 1-4
  void _handleBatteryLevelCommand(List<int> bytes) {
    _batteryLevelStreamController.add(bytes[5]);
  }

  void _handleDeviceFound() {
    _deviceFoundStreamController.add(true);
  }

  void _handleDeviceReset() {
    _deviceResetStreamController.add(true);
  }

  void _handleReadCommand(List<int> bytes) {
    final key = bytes[2].toRadixString(16).padLeft(2, '0');
    switch (key) {
      case BleDeviceCommands.firmwareVersionKey:
        _handleFirmwareVersionCommand(bytes);
        break;
      case BleDeviceCommands.batteryKey:
        _handleBatteryLevelCommand(bytes);
        break;
    }
  }

  void _handleNotificationCommand(List<int> bytes) {
    final key = bytes[2].toRadixString(16).padLeft(2, '0');
    switch (key) {
      case BleDeviceCommands.deviceFoundKey:
        _handleDeviceFound();
        break;
      case BleDeviceCommands.deviceReset:
        _handleDeviceReset();
        break;
    }
  }

  Future<void> _readCommand(List<int> bytes) async {
    try {
      final command = bytes[1].toRadixString(16).padLeft(2, '0');
      if (command == BleDeviceCommands.commandRead) {
        _handleReadCommand(bytes);
        return;
      }
      if (command == BleDeviceCommands.commandNotification) {
        _handleNotificationCommand(bytes);
        return;
      }
    } catch (_) {}
  }

  @override
  Future<void> connect() async {
    if (_bluetoothDevice.isConnected) {
      return;
    }
    _deviceConnectionStateController.add(BleDeviceConnectionState.connecting);
    _delayDisconnectionState = true;
    await _bluetoothDevice.connect(autoConnect: true, mtu: null);
  }

  @override
  Future<void> disconnect() async {
    if (!_bluetoothDevice.isConnected) {
      return;
    }
    _connectionStateSubscription?.cancel();
    await _bluetoothDevice.disconnect();
  }

  @override
  Future<void> checkMetronomeNotification() async {
    final command = _convertToCommand(
        command: BleDeviceCommands.commandWrite,
        key: BleDeviceCommands.metronomeNotificationCheckKey);
    await _writeCommand(command);
  }

  @override
  Future<void> checkTimerNotification() async {
    final command = _convertToCommand(
        command: BleDeviceCommands.commandWrite,
        key: BleDeviceCommands.timerNotificationCheckKey);
    await _writeCommand(command);
  }

  @override
  Future<void> disableAllAlarmsUntilNow() async {
    final command = _convertToCommand(
        command: BleDeviceCommands.commandWrite,
        key: BleDeviceCommands.alarmsDisableKey);
    await _writeCommand(command);
  }

  @override
  Future<void> findDevice(bool enable) async {
    final enableValue = enable ? '01' : '00';
    final command = _convertToCommand(
        command: BleDeviceCommands.commandWrite,
        key: BleDeviceCommands.deviceFindKey,
        value: enableValue);
    await _writeCommand(command);
  }

  @override
  Future<void> queueBatteryLevel() async {
    final command = _convertToCommand(
        command: BleDeviceCommands.commandRead,
        key: BleDeviceCommands.batteryKey);
    await _writeCommand(command);
  }

  @override
  Future<void> queueFirmwareVersion() async {
    final command = _convertToCommand(
        command: BleDeviceCommands.commandRead,
        key: BleDeviceCommands.firmwareVersionKey);
    await _writeCommand(command);
  }

  @override
  Future<void> setAlarms(List<DateTime> alarms) async {
    final buffer = StringBuffer();
    for (final alarm in alarms) {
      if (buffer.isNotEmpty) {
        buffer.write('00');
      }
      final year = (alarm.year - 2000).toRadixString(16).padLeft(2, '0');
      final month = alarm.month.toRadixString(16).padLeft(2, '0');
      final day = alarm.day.toRadixString(16).padLeft(2, '0');
      final hour = alarm.hour.toRadixString(16).padLeft(2, '0');
      final minutes = alarm.minute.toRadixString(16).padLeft(2, '0');

      buffer.write(year);
      buffer.write(month);
      buffer.write(day);
      buffer.write(hour);
      buffer.write(minutes);
    }
    final command = _convertToCommand(
        command: BleDeviceCommands.commandWrite,
        key: BleDeviceCommands.alarmsKey,
        value: buffer.isEmpty ? null : buffer.toString());
    await _writeCommand(command);
  }

  @override
  Future<void> setCurrentDateTime(DateTime dateTime) async {
    final year = (dateTime.year - 2000).toRadixString(16).padLeft(2, '0');
    final month = dateTime.month.toRadixString(16).padLeft(2, '0');
    final day = dateTime.day.toRadixString(16).padLeft(2, '0');
    final hour = dateTime.hour.toRadixString(16).padLeft(2, '0');
    final minute = dateTime.minute.toRadixString(16).padLeft(2, '0');
    final weekDay = dateTime.weekday.toRadixString(16).padLeft(2, '0');

    final timeCommand = _convertToCommand(
        command: BleDeviceCommands.commandWrite,
        key: BleDeviceCommands.timeKey,
        value: '$hour$minute');

    final dateCommand = _convertToCommand(
        command: BleDeviceCommands.commandWrite,
        key: BleDeviceCommands.dateKey,
        value: '$year$month$day$weekDay');

    await _writeCommand(dateCommand);
    await _writeCommand(timeCommand);
  }

  @override
  Future<void> setMetronome(
      {required int bpm, required int tact, required bool skipOneTact}) async {
    final bpmString = bpm.toRadixString(16).padLeft(2, '0');
    final tactString = tact.toRadixString(16).padLeft(2, '0');
    final skipOneTactString = skipOneTact ? '01' : '00';

    final command = _convertToCommand(
        command: BleDeviceCommands.commandWrite,
        key: BleDeviceCommands.metronomeKey,
        value: '$bpmString$tactString$skipOneTactString');
    await _writeCommand(command);
  }

  @override
  Future<void> resetMetronome() async {
    final command = _convertToCommand(
        command: BleDeviceCommands.commandWrite,
        key: BleDeviceCommands.metronomeKey);
    await _writeCommand(command);
  }

  @override
  Future<void> setMetronomeNotification(
      NotificationType type, int intensity) async {
    final typeString = type == NotificationType.vibration ? '00' : '01';
    final intensityString = intensity.toRadixString(16).padLeft(2, '0');
    final command = _convertToCommand(
        command: BleDeviceCommands.commandWrite,
        key: BleDeviceCommands.metronomeNotificationKey,
        value: '$typeString$intensityString');
    await _writeCommand(command);
  }

  @override
  Future<void> setName(String name) async {
    final bytesList = utf8.encode(name);
    final command = _convertToCommand(
        command: BleDeviceCommands.commandWrite,
        key: BleDeviceCommands.deviceNameKey,
        value: hex.encode(bytesList));
    await _writeCommand(command);
  }

  @override
  Future<void> setTimer(DateTime? dateTime) async {
    String? timerValue;

    if (dateTime != null) {
      final buffer = StringBuffer();
      final year = (dateTime.year - 2000).toRadixString(16).padLeft(2, '0');
      final month = dateTime.month.toRadixString(16).padLeft(2, '0');
      final day = dateTime.day.toRadixString(16).padLeft(2, '0');
      final hour = dateTime.hour.toRadixString(16).padLeft(2, '0');
      final minutes = dateTime.minute.toRadixString(16).padLeft(2, '0');

      buffer.write(year);
      buffer.write(month);
      buffer.write(day);
      buffer.write(hour);
      buffer.write(minutes);
      timerValue = buffer.toString();
    }

    final command = _convertToCommand(
        command: BleDeviceCommands.commandWrite,
        key: BleDeviceCommands.timerKey,
        value: timerValue);
    await _writeCommand(command);
  }

  @override
  Future<void> setTimerDuration(DateTime? dateTime) async {
    String? durationValue;

    if (dateTime != null) {
      final buffer = StringBuffer();
      final year = (dateTime.year - 2000).toRadixString(16).padLeft(2, '0');
      final month = dateTime.month.toRadixString(16).padLeft(2, '0');
      final day = dateTime.day.toRadixString(16).padLeft(2, '0');
      final hour = dateTime.hour.toRadixString(16).padLeft(2, '0');
      final minutes = dateTime.minute.toRadixString(16).padLeft(2, '0');

      buffer.write(year);
      buffer.write(month);
      buffer.write(day);
      buffer.write(hour);
      buffer.write(minutes);
      durationValue = buffer.toString();
    }

    final command = _convertToCommand(
        command: BleDeviceCommands.commandWrite,
        key: BleDeviceCommands.timerDurationKey,
        value: durationValue);
    await _writeCommand(command);
  }

  @override
  Future<void> setTimerInterval(Duration duration) async {
    final minutes =
        duration.inMinutes.remainder(60).toRadixString(16).padLeft(2, '0');
    final seconds =
        duration.inSeconds.remainder(60).toRadixString(16).padLeft(2, '0');

    final command = _convertToCommand(
        command: BleDeviceCommands.commandWrite,
        key: BleDeviceCommands.timerIntervalKey,
        value: '$minutes$seconds');
    await _writeCommand(command);
  }

  @override
  Future<void> setTimerNotification(
      NotificationType type, int intensity) async {
    final typeString = type == NotificationType.vibration ? '00' : '01';
    final intensityString = intensity.toRadixString(16).padLeft(2, '0');
    final command = _convertToCommand(
        command: BleDeviceCommands.commandWrite,
        key: BleDeviceCommands.timerNotificationKey,
        value: '$typeString$intensityString');
    await _writeCommand(command);
  }

  @override
  Future<void> unpair() async {
    final command = _convertToCommand(
        command: BleDeviceCommands.commandWrite,
        key: BleDeviceCommands.unpairKey);
    await _writeCommand(command);
  }

  @override
  Future<void> setLanguage(int language) async {
    final command = _convertToCommand(
        command: BleDeviceCommands.commandWrite,
        key: BleDeviceCommands.languageKey,
        value: language.toRadixString(16).padLeft(2, '0'));
    await _writeCommand(command);
  }
}
