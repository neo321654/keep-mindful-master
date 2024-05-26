import 'dart:math' as math;

const _maxCombinations = 10;
const _maxNumber = 100;

class MathQuizGenerator {
  String? _quiz;
  String? _answer;

  String? get quiz => _quiz;
  String? get answer => _answer;

  void getQuiz() {
    final random = math.Random();
    final num1 = random.nextInt(_maxNumber);
    final num2 = random.nextInt(_maxNumber);
    final num3 = random.nextInt(_maxNumber);

    final intCombination = random.nextInt(_maxCombinations);
    _answer = _getAnswer(
        num1: num1, num2: num2, num3: num3, combinationId: intCombination);
    _quiz = _generateQuiz(
        num1: num1, num2: num2, num3: num3, combinationId: intCombination);
  }

  String _getAnswer(
      {required int num1,
      required int num2,
      required int num3,
      required int combinationId}) {
    final map = {
      0: num1 + num2 - num3,
      1: num1 + num2 * num3,
      2: num1 - num2 + num3,
      3: num1 - num2 * num3,
      4: num1 * num2 + num3,
      5: num1 * num2 - num3,
      6: num1 + num2 + num3,
      7: num1 - num2 - num3,
      8: num1 * num2 * num3,
      9: num1 * num2 + num3,
    };
    return '${map[combinationId]}';
  }

  String _generateQuiz(
      {required int num1,
      required int num2,
      required int num3,
      required int combinationId}) {
    final map = {
      0: '$num1 + $num2 - $num3',
      1: '$num1 + $num2 * $num3',
      2: '$num1 - $num2 + $num3',
      3: '$num1 - $num2 * $num3',
      4: '$num1 * $num2 + $num3',
      5: '$num1 * $num2 - $num3',
      6: '$num1 + $num2 + $num3',
      7: '$num1 - $num2 - $num3',
      8: '$num1 * $num2 * $num3',
      9: '$num1 * $num2 + $num3',
    };
    return map[combinationId]!;
  }
}
