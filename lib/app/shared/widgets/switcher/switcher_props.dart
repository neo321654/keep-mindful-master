class SwitcherProps {
  SwitcherProps({
    this.value = false,
    this.onChange,
  });

  final bool value;
  final void Function(bool)? onChange;
}
