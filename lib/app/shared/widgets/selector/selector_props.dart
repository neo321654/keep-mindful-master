class SelectorItemProps {
  const SelectorItemProps({required this.title, required this.value});

  final String title;
  final String value;
}

class SelectorProps {
  const SelectorProps({
    this.groupValue,
    required this.items,
    this.onPressed,
  }) : assert(items.length > 1, 'Provide more than one element');

  final String? groupValue;
  final List<SelectorItemProps> items;
  final void Function(String value)? onPressed;
}
