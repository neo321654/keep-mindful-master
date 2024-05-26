import 'dart:convert';

import '../../features.dart';

class AlarmDisableQrCodeService {
  AlarmDisableQrCodeService(AlarmDisableQrCodeRepository repository)
      : _repository = repository;

  final AlarmDisableQrCodeRepository _repository;

  String? getQr() {
    return _repository.get();
  }

  Future<void> generateQrIfNotExists() async {
    if (getQr() != null) {
      return;
    }
    await _repository.set(_generateQr());
  }

  bool isQrCorrect(String qr) {
    return getQr() == qr;
  }

  String _generateQr() {
    final generatedDate = DateTime.now().toString();
    final codec = utf8.fuse(base64);
    return codec.encode('keep_mindfull_$generatedDate');
  }
}
