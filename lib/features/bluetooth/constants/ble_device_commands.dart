class BleDeviceCommands {
  const BleDeviceCommands._();

  static const commandWrite = '01';
  static const commandRead = '02';
  static const commandNotification = '03';

  static const deviceFindKey = '02';
  static const deviceNameKey = '03';
  static const unpairKey = '04';
  static const timeKey = '05';
  static const dateKey = '06';
  static const firmwareUpdateKey = '07';
  static const timerKey = '08';
  static const timerDurationKey = '09';
  static const timerIntervalKey = '0A';
  static const timerNotificationKey = '0B';
  static const timerNotificationCheckKey = '0C';
  static const metronomeKey = '0D';
  static const metronomeNotificationKey = '0E';
  static const metronomeNotificationCheckKey = '0F';
  static const alarmsKey = '10';
  static const alarmsDisableKey = '11';
  static const languageKey = '12';

  static const firmwareVersionKey = '01';
  static const batteryKey = '02';

  static const deviceFoundKey = '01';
  static const deviceReset = '02';
}
