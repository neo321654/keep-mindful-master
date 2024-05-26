import '../repositories/repositories.dart';

class AlarmDisableQrShownService {
  AlarmDisableQrShownService(AlarmDisableQrShownRepository repository)
      : _repository = repository;

  final AlarmDisableQrShownRepository _repository;

  bool wasShown() {
    final wasShown = _repository.get();

    if (wasShown == null) {
      return false;
    }

    return wasShown;
  }

  Future<void> markAsShown() {
    return _repository.set(true);
  }
}
