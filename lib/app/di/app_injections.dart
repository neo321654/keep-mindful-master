import 'package:get_it/get_it.dart';

import '../../features/features.dart';
import '../router/app_router.dart';

class AppInjections {
  const AppInjections._();

  static void register() {
    final getIt = GetIt.instance;

    getIt.registerSingleton(AppRouter());
    getIt.registerSingleton(
        AwakeningNotifier(AlarmsRepository(), AwakeningRepository()));
    getIt.registerSingleton(WakeUpModeNotifier(WakeUpModeRepository()));
    getIt.registerFactory(
        () => AlarmDisableQrShownService(AlarmDisableQrShownRepository()));
    getIt.registerFactory(
        () => AlarmDisableQrCodeService(AlarmDisableQrCodeRepository()));
    getIt.registerSingleton(IntervalNotifier(IntervalRepository()));
    getIt.registerSingleton(TimerNotifier(TimerRepository()));
    getIt.registerSingleton(DurationNotifier(DurationRepository()));

    getIt.registerSingleton(
        BluetoothDeviceStateNotifier(BluetoothDeviceRepository()));
    getIt.registerFactory(
        () => BluetoothAdapterStateNotifier(const BleEnableService()));
    getIt.registerFactory(
        () => BluetoothDevicesScanNotifier(const BleDevicesService()));
    getIt.registerFactory(() => BluetoothDeviceBatteryNotifier(getIt()));

    getIt.registerFactory(() => IntensityNotifier());

    getIt.registerFactory(() => TimerSynchronizer(
        timerRepository: TimerRepository(),
        durationRepository: DurationRepository(),
        intervalRepository: IntervalRepository()));

    getIt.registerFactory(() => IntensitySynchronizer(
        timerRepository: IntensityTimerRepository(),
        metronomeRepository: IntensityMetronomeRepository()));
    getIt.registerFactory(() => MetronomeNotifier(MetronomeRepository()));
    getIt.registerFactory(() =>
        MetronomeSynchronizer(metronomeRepository: MetronomeRepository()));
    getIt.registerFactory(() =>
        AppLanguageSynchronizer(languageRepository: AppLanguageRepository()));

    getIt.registerFactory(() => AwakeningSynchronizer(
        awakeningRepository: AwakeningRepository(),
        alarmsRepository: AlarmsRepository()));

    getIt.registerSingleton(AppLanguageNotifier(AppLanguageRepository()));
  }
}
