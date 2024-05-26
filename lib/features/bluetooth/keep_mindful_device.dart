import 'constants/constants.dart';

abstract class KeepMindfulDevice {
  const KeepMindfulDevice();

  String get remoteId;

  Stream<int> get firmwareVersionNumber;
  Stream<int> get batteryLevel;
  Stream<bool> get deviceFound;
  Stream<bool> get deviceReset;
  Stream<BleDeviceConnectionState> get connectionState;
  bool get isConnected;

  Future<void> connect();
  Future<void> disconnect();

  Future<void> findDevice(bool enable);
  Future<void> setName(String name);
  Future<void> unpair();
  Future<void> setCurrentDateTime(DateTime dateTime);
  Future<void> setLanguage(int language);

  Future<void> setTimer(DateTime? dateTime);
  Future<void> setTimerDuration(DateTime? dateTime);
  Future<void> setTimerInterval(Duration duration);
  Future<void> setTimerNotification(NotificationType type, int intensity);
  Future<void> checkTimerNotification();

  Future<void> setMetronome(
      {required int bpm, required int tact, required bool skipOneTact});
  Future<void> resetMetronome();
  Future<void> setMetronomeNotification(NotificationType type, int intensity);
  Future<void> checkMetronomeNotification();

  Future<void> setAlarms(List<DateTime> alarms);
  Future<void> disableAllAlarmsUntilNow();

  Future<void> queueFirmwareVersion();
  Future<void> queueBatteryLevel();
}
