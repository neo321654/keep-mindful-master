import 'dart:math';

const _chars = 'abdefghnryABDEFGHNQRY3468';
const _length = 7;

class CaptchaWordGenerator {
  String generateRandomText() {
    final random = Random();
    final charList = _chars.runes.toList(growable: false);
    final textBuffer = StringBuffer();
    for (var i = 0; i < _length; i++) {
      final index = random.nextInt(charList.length);
      textBuffer.write(String.fromCharCode(charList[index]));
    }
    return textBuffer.toString();
  }
}
