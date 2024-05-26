class MinutesButtonProps {
  const MinutesButtonProps({required this.minutes, this.onPressed});

  final int minutes;
  final void Function(int)? onPressed;
}
