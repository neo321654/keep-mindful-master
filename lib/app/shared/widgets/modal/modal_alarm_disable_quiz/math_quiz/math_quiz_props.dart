class MathQuizProps {
  const MathQuizProps(
      {this.onQuizPassed, required this.quiz, required this.answer});

  final void Function()? onQuizPassed;
  final String quiz;
  final String answer;
}
