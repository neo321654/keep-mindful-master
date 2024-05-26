class AlarmItemProps {
  const AlarmItemProps(
      {required this.name,
      required this.time,
      this.isActive = false,
      this.onPressed,
      this.onActivatePressed});

  final String name;
  final DateTime time;
  final bool isActive;
  final void Function()? onPressed;
  final void Function(bool)? onActivatePressed;
}
