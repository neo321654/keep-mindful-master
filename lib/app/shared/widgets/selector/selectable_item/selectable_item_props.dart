class SelectableItemProps {
  const SelectableItemProps(
      {required this.value,
      required this.title,
      this.groupValue,
      this.onPressed});

  final String value;
  final String title;
  final String? groupValue;

  final void Function(String)? onPressed;
}
