class ControllerBarProps {
  const ControllerBarProps(
      {this.isActive = false,
      this.onNextPressed,
      this.onPreviousPressed,
      this.onStartPressed});

  final bool isActive;
  final void Function()? onNextPressed;
  final void Function()? onStartPressed;
  final void Function()? onPreviousPressed;
}
