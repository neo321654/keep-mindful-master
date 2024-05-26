class SoundSwitcherProps {
  const SoundSwitcherProps({this.isSelected = false, this.onChanged});

  final bool isSelected;
  final void Function(bool)? onChanged;
}
