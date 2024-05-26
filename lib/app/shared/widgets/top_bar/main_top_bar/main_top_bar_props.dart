import '../../dropdown/dropdown.dart';

const _defaultMenuWidth = 170.0;

class MainTopBarProps {
  const MainTopBarProps(
      {this.menuItems = const [],
      this.selectedMenuItemPosition,
      this.onMenuItemPressed,
      this.menuWidth = _defaultMenuWidth});
  final List<DropdownItemProps> menuItems;
  final int? selectedMenuItemPosition;
  final void Function(int)? onMenuItemPressed;
  final double menuWidth;
}
