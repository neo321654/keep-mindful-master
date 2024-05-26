class TimeActionsBarProps {
  const TimeActionsBarProps(
      {this.isActive = false,
      this.onStopPressed,
      this.onIntervalPressed,
      this.onStartPressed});

  final bool isActive;
  final void Function()? onStopPressed;
  final void Function()? onStartPressed;
  final void Function()? onIntervalPressed;
}
