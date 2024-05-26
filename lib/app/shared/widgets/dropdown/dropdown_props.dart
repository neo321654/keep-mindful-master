import 'dropdown_item_props.dart';

class DropdownProps {
  const DropdownProps(
      {this.value, required this.values, this.onChanged, this.width});

  final DropdownItemProps? value;
  final List<DropdownItemProps> values;
  final void Function(DropdownItemProps?)? onChanged;
  final double? width;
}
