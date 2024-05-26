// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(_current != null,
        'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Keep mindful`
  String get appName {
    return Intl.message(
      'Keep mindful',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Use Bluetooth to connect the ring`
  String get bluetoothTurnOnHint {
    return Intl.message(
      'Use Bluetooth to connect the ring',
      name: 'bluetoothTurnOnHint',
      desc: '',
      args: [],
    );
  }

  /// `Available devices`
  String get bluetoothAvailableDevices {
    return Intl.message(
      'Available devices',
      name: 'bluetoothAvailableDevices',
      desc: '',
      args: [],
    );
  }

  /// `Press`
  String get bluetoothConnectHintFirst {
    return Intl.message(
      'Press',
      name: 'bluetoothConnectHintFirst',
      desc: '',
      args: [],
    );
  }

  /// `to pair`
  String get bluetoothConnectHintSecond {
    return Intl.message(
      'to pair',
      name: 'bluetoothConnectHintSecond',
      desc: '',
      args: [],
    );
  }

  /// `Scan`
  String get bluetoothToScan {
    return Intl.message(
      'Scan',
      name: 'bluetoothToScan',
      desc: '',
      args: [],
    );
  }

  /// `Enable Bluetooth`
  String get bluetoothTurnOnButton {
    return Intl.message(
      'Enable Bluetooth',
      name: 'bluetoothTurnOnButton',
      desc: '',
      args: [],
    );
  }

  /// `Hours`
  String get hours {
    return Intl.message(
      'Hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get minutes {
    return Intl.message(
      'Minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `Seconds`
  String get seconds {
    return Intl.message(
      'Seconds',
      name: 'seconds',
      desc: '',
      args: [],
    );
  }

  /// `Timer`
  String get timerTitle {
    return Intl.message(
      'Timer',
      name: 'timerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Set the duration`
  String get timerSetDuration {
    return Intl.message(
      'Set the duration',
      name: 'timerSetDuration',
      desc: '',
      args: [],
    );
  }

  /// `min`
  String get min {
    return Intl.message(
      'min',
      name: 'min',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get intervalSave {
    return Intl.message(
      'Save',
      name: 'intervalSave',
      desc: '',
      args: [],
    );
  }

  /// `Interval`
  String get intervalTitle {
    return Intl.message(
      'Interval',
      name: 'intervalTitle',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get durationTitle {
    return Intl.message(
      'Duration',
      name: 'durationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Intensity`
  String get intensity {
    return Intl.message(
      'Intensity',
      name: 'intensity',
      desc: '',
      args: [],
    );
  }

  /// `Vibration`
  String get intensityVibration {
    return Intl.message(
      'Vibration',
      name: 'intensityVibration',
      desc: '',
      args: [],
    );
  }

  /// `Charge`
  String get intensityDischarge {
    return Intl.message(
      'Charge',
      name: 'intensityDischarge',
      desc: '',
      args: [],
    );
  }

  /// `Check the selected intensity`
  String get intensityCheckSelectedIntensity {
    return Intl.message(
      'Check the selected intensity',
      name: 'intensityCheckSelectedIntensity',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsTitle {
    return Intl.message(
      'Settings',
      name: 'settingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get settingsTheme {
    return Intl.message(
      'Theme',
      name: 'settingsTheme',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get settingsNotifications {
    return Intl.message(
      'Notifications',
      name: 'settingsNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Low battery charge`
  String get settingsBatteryLow {
    return Intl.message(
      'Low battery charge',
      name: 'settingsBatteryLow',
      desc: '',
      args: [],
    );
  }

  /// `Intelligence`
  String get settingsDetails {
    return Intl.message(
      'Intelligence',
      name: 'settingsDetails',
      desc: '',
      args: [],
    );
  }

  /// `About the app`
  String get settingsAboutApp {
    return Intl.message(
      'About the app',
      name: 'settingsAboutApp',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get settingsTermsConditions {
    return Intl.message(
      'Privacy policy',
      name: 'settingsTermsConditions',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get settingsFaq {
    return Intl.message(
      'FAQ',
      name: 'settingsFaq',
      desc: '',
      args: [],
    );
  }

  /// `Setting up a theme`
  String get themeTitle {
    return Intl.message(
      'Setting up a theme',
      name: 'themeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get themeDark {
    return Intl.message(
      'Dark',
      name: 'themeDark',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get themeLight {
    return Intl.message(
      'Light',
      name: 'themeLight',
      desc: '',
      args: [],
    );
  }

  /// `System Setup`
  String get themeSystem {
    return Intl.message(
      'System Setup',
      name: 'themeSystem',
      desc: '',
      args: [],
    );
  }

  /// `About the app`
  String get aboutAppTitle {
    return Intl.message(
      'About the app',
      name: 'aboutAppTitle',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get termsConditionsTitle {
    return Intl.message(
      'Privacy policy',
      name: 'termsConditionsTitle',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get faqTitle {
    return Intl.message(
      'FAQ',
      name: 'faqTitle',
      desc: '',
      args: [],
    );
  }

  /// `Metronome`
  String get metronomeTitle {
    return Intl.message(
      'Metronome',
      name: 'metronomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Awakening`
  String get awakeningTitle {
    return Intl.message(
      'Awakening',
      name: 'awakeningTitle',
      desc: '',
      args: [],
    );
  }

  /// `Number of bars`
  String get metronomeNumberOfBars {
    return Intl.message(
      'Number of bars',
      name: 'metronomeNumberOfBars',
      desc: '',
      args: [],
    );
  }

  /// `Pace`
  String get metronomePace {
    return Intl.message(
      'Pace',
      name: 'metronomePace',
      desc: '',
      args: [],
    );
  }

  /// `1 bar with sound and 1 bar without sound`
  String get metronomeSoundSwitherTitle {
    return Intl.message(
      '1 bar with sound and 1 bar without sound',
      name: 'metronomeSoundSwitherTitle',
      desc: '',
      args: [],
    );
  }

  /// `Alarm clocks`
  String get awakeningAlarmClocks {
    return Intl.message(
      'Alarm clocks',
      name: 'awakeningAlarmClocks',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any alarm\nclocks added yet`
  String get awakeningAlarmsEmpty {
    return Intl.message(
      'You don\'t have any alarm\nclocks added yet',
      name: 'awakeningAlarmsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get awakeningAlarmAdd {
    return Intl.message(
      'Add',
      name: 'awakeningAlarmAdd',
      desc: '',
      args: [],
    );
  }

  /// `Delete an alarm clock`
  String get awakeningAlarmRemove {
    return Intl.message(
      'Delete an alarm clock',
      name: 'awakeningAlarmRemove',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get awakeningAlarmSave {
    return Intl.message(
      'Save',
      name: 'awakeningAlarmSave',
      desc: '',
      args: [],
    );
  }

  /// `To turn off the alarm, you will need to scan this QR code`
  String get awakeningAlarmDisableQrTitle {
    return Intl.message(
      'To turn off the alarm, you will need to scan this QR code',
      name: 'awakeningAlarmDisableQrTitle',
      desc: '',
      args: [],
    );
  }

  /// `You can choose how to turn off the alarm in the app Settings`
  String get awakeningAlarmDisableQrHint {
    return Intl.message(
      'You can choose how to turn off the alarm in the app Settings',
      name: 'awakeningAlarmDisableQrHint',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get awakeningAlarmQrDownload {
    return Intl.message(
      'Download',
      name: 'awakeningAlarmQrDownload',
      desc: '',
      args: [],
    );
  }

  /// `Disabling the "Wake Up" mode`
  String get wakeUpModeTitle {
    return Intl.message(
      'Disabling the "Wake Up" mode',
      name: 'wakeUpModeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Scan the QR code`
  String get wakeUpModeQr {
    return Intl.message(
      'Scan the QR code',
      name: 'wakeUpModeQr',
      desc: '',
      args: [],
    );
  }

  /// `Solve a mathematical problem`
  String get wakeUpModeMathExcercise {
    return Intl.message(
      'Solve a mathematical problem',
      name: 'wakeUpModeMathExcercise',
      desc: '',
      args: [],
    );
  }

  /// `Captcha`
  String get wakeUpCaptcha {
    return Intl.message(
      'Captcha',
      name: 'wakeUpCaptcha',
      desc: '',
      args: [],
    );
  }

  /// `Disabling the "Wake Up" mode`
  String get settingsWakeUpMode {
    return Intl.message(
      'Disabling the "Wake Up" mode',
      name: 'settingsWakeUpMode',
      desc: '',
      args: [],
    );
  }

  /// `Show QR code`
  String get settingsWakeUpShowQrButton {
    return Intl.message(
      'Show QR code',
      name: 'settingsWakeUpShowQrButton',
      desc: '',
      args: [],
    );
  }

  /// `To turn off the alarm, scan the QR code`
  String get alarmDisableQrTitle {
    return Intl.message(
      'To turn off the alarm, scan the QR code',
      name: 'alarmDisableQrTitle',
      desc: '',
      args: [],
    );
  }

  /// `Disable it in another way`
  String get alarmDisableAnotherWayButton {
    return Intl.message(
      'Disable it in another way',
      name: 'alarmDisableAnotherWayButton',
      desc: '',
      args: [],
    );
  }

  /// `To turn off the alarm, you need to solve the problem:`
  String get alarmDisableMathExcerciseTitle {
    return Intl.message(
      'To turn off the alarm, you need to solve the problem:',
      name: 'alarmDisableMathExcerciseTitle',
      desc: '',
      args: [],
    );
  }

  /// `Answer`
  String get alarmDisableMathExcerciseInputHint {
    return Intl.message(
      'Answer',
      name: 'alarmDisableMathExcerciseInputHint',
      desc: '',
      args: [],
    );
  }

  /// `The alarm is off`
  String get alarmDisableQrConfirmed {
    return Intl.message(
      'The alarm is off',
      name: 'alarmDisableQrConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `Scan`
  String get bluetoothDevicesSearchButton {
    return Intl.message(
      'Scan',
      name: 'bluetoothDevicesSearchButton',
      desc: '',
      args: [],
    );
  }

  /// `Is vibration in the ring dangerous for humans?`
  String get faqQuestion {
    return Intl.message(
      'Is vibration in the ring dangerous for humans?',
      name: 'faqQuestion',
      desc: '',
      args: [],
    );
  }

  /// `No, such vibration cannot cause any harm to human health.`
  String get faqAnswer {
    return Intl.message(
      'No, such vibration cannot cause any harm to human health.',
      name: 'faqAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Can a person with a pacemaker use this ring?`
  String get faqQuestion1 {
    return Intl.message(
      'Can a person with a pacemaker use this ring?',
      name: 'faqQuestion1',
      desc: '',
      args: [],
    );
  }

  /// `Yes, they can. In 'vibration' mode, any intensity level can be used. In 'shocker' mode, a reduced intensity level should be used and consultation with a doctor is advised before use.`
  String get faqAnswer1 {
    return Intl.message(
      'Yes, they can. In \'vibration\' mode, any intensity level can be used. In \'shocker\' mode, a reduced intensity level should be used and consultation with a doctor is advised before use.',
      name: 'faqAnswer1',
      desc: '',
      args: [],
    );
  }

  /// `Why should I choose a ring instead of a wristband to use as an alarm or reminder?`
  String get faqQuestion2 {
    return Intl.message(
      'Why should I choose a ring instead of a wristband to use as an alarm or reminder?',
      name: 'faqQuestion2',
      desc: '',
      args: [],
    );
  }

  /// `Vibration in 'Wake-up' mode will provide you with a gentle and silent wake-up, and if that is not enough, the 'shocker' function will help you fully wake up. If you need the ring to vibrate, for example, every 15-20 seconds for an hour, you would need to set up more than 200 alarms on a smartwatch. This program can be set up in a few clicks in the ring's app.`
  String get faqAnswer2 {
    return Intl.message(
      'Vibration in \'Wake-up\' mode will provide you with a gentle and silent wake-up, and if that is not enough, the \'shocker\' function will help you fully wake up. If you need the ring to vibrate, for example, every 15-20 seconds for an hour, you would need to set up more than 200 alarms on a smartwatch. This program can be set up in a few clicks in the ring\'s app.',
      name: 'faqAnswer2',
      desc: '',
      args: [],
    );
  }

  /// `How long does the ring hold a charge?`
  String get faqQuestion3 {
    return Intl.message(
      'How long does the ring hold a charge?',
      name: 'faqQuestion3',
      desc: '',
      args: [],
    );
  }

  /// `In average usage mode, it lasts for 15-20 hours.`
  String get faqAnswer3 {
    return Intl.message(
      'In average usage mode, it lasts for 15-20 hours.',
      name: 'faqAnswer3',
      desc: '',
      args: [],
    );
  }

  /// `Can I connect more than one ring to the app?`
  String get faqQuestion4 {
    return Intl.message(
      'Can I connect more than one ring to the app?',
      name: 'faqQuestion4',
      desc: '',
      args: [],
    );
  }

  /// `No.`
  String get faqAnswer4 {
    return Intl.message(
      'No.',
      name: 'faqAnswer4',
      desc: '',
      args: [],
    );
  }

  /// `What voltage does the shocker produce?`
  String get faqQuestion5 {
    return Intl.message(
      'What voltage does the shocker produce?',
      name: 'faqQuestion5',
      desc: '',
      args: [],
    );
  }

  /// `From 50V to 150V.`
  String get faqAnswer5 {
    return Intl.message(
      'From 50V to 150V.',
      name: 'faqAnswer5',
      desc: '',
      args: [],
    );
  }

  /// `Is this voltage dangerous for human health?`
  String get faqQuestion6 {
    return Intl.message(
      'Is this voltage dangerous for human health?',
      name: 'faqQuestion6',
      desc: '',
      args: [],
    );
  }

  /// `No. The impact in 'shocker' mode is very brief and cannot harm a healthy organism.`
  String get faqAnswer6 {
    return Intl.message(
      'No. The impact in \'shocker\' mode is very brief and cannot harm a healthy organism.',
      name: 'faqAnswer6',
      desc: '',
      args: [],
    );
  }

  /// `What is the battery capacity?`
  String get faqQuestion7 {
    return Intl.message(
      'What is the battery capacity?',
      name: 'faqQuestion7',
      desc: '',
      args: [],
    );
  }

  /// `50mA.`
  String get faqAnswer7 {
    return Intl.message(
      '50mA.',
      name: 'faqAnswer7',
      desc: '',
      args: [],
    );
  }

  /// `How long can the ring work without charging in standby mode?`
  String get faqQuestion8 {
    return Intl.message(
      'How long can the ring work without charging in standby mode?',
      name: 'faqQuestion8',
      desc: '',
      args: [],
    );
  }

  /// `Up to two days.`
  String get faqAnswer8 {
    return Intl.message(
      'Up to two days.',
      name: 'faqAnswer8',
      desc: '',
      args: [],
    );
  }

  /// `What is the ring's level of water resistance?`
  String get faqQuestion9 {
    return Intl.message(
      'What is the ring\'s level of water resistance?',
      name: 'faqQuestion9',
      desc: '',
      args: [],
    );
  }

  /// `IPX4 means that the device is resistant to water only at the splash level. The ring can be worn on rainy days and during hand washing, but it cannot be submerged in water.`
  String get faqAnswer9 {
    return Intl.message(
      'IPX4 means that the device is resistant to water only at the splash level. The ring can be worn on rainy days and during hand washing, but it cannot be submerged in water.',
      name: 'faqAnswer9',
      desc: '',
      args: [],
    );
  }

  /// `How will the ring work when it loses connection with the mobile app?`
  String get faqQuestion10 {
    return Intl.message(
      'How will the ring work when it loses connection with the mobile app?',
      name: 'faqQuestion10',
      desc: '',
      args: [],
    );
  }

  /// `Only the basic settings programmed into the gadget will be saved. When the ring returns to the Bluetooth signal range of the mobile device, the settings of the previously set mode will be restored.`
  String get faqAnswer10 {
    return Intl.message(
      'Only the basic settings programmed into the gadget will be saved. When the ring returns to the Bluetooth signal range of the mobile device, the settings of the previously set mode will be restored.',
      name: 'faqAnswer10',
      desc: '',
      args: [],
    );
  }

  /// `Not connected`
  String get notConnected {
    return Intl.message(
      'Not connected',
      name: 'notConnected',
      desc: '',
      args: [],
    );
  }

  /// `To turn off the alarm, enter the word from the picture:`
  String get captchaTitle {
    return Intl.message(
      'To turn off the alarm, enter the word from the picture:',
      name: 'captchaTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter the word`
  String get captchaInputHint {
    return Intl.message(
      'Enter the word',
      name: 'captchaInputHint',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settingsLanguage {
    return Intl.message(
      'Language',
      name: 'settingsLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Setting up language`
  String get languageTitle {
    return Intl.message(
      'Setting up language',
      name: 'languageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Battery indicator`
  String get batteryIndicatorSemanticsLabel {
    return Intl.message(
      'Battery indicator',
      name: 'batteryIndicatorSemanticsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Bluetooth`
  String get bluetoothSemanticsLabel {
    return Intl.message(
      'Bluetooth',
      name: 'bluetoothSemanticsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Play/Pause`
  String get playPauseSemanticsLabel {
    return Intl.message(
      'Play/Pause',
      name: 'playPauseSemanticsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get resetSemanticsLabel {
    return Intl.message(
      'Reset',
      name: 'resetSemanticsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get previousSemanticsLabel {
    return Intl.message(
      'Previous',
      name: 'previousSemanticsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get nextSemanticsLabel {
    return Intl.message(
      'Next',
      name: 'nextSemanticsLabel',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
