import '../../bluetooth/bluetooth.dart';

abstract class IntensityRepository {
  int? getPower();

  Future<void> setPower(int power);

  NotificationType? getIntensityType();

  Future<void> setIntensityType(NotificationType intensity);

  Future<void> reset();

  DateTime? getUpdatedAt();

  DateTime? getSentAt();

  Future<void> setSentNow();
}
