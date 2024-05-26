import 'bottom_navigation_bar_item.dart';

class BottomNavigationBarProps {
  const BottomNavigationBarProps(
      {this.selectedPosition = 0, this.onPressed, this.items = const []});

  final int selectedPosition;
  final void Function(int)? onPressed;
  final List<BottomNavigationBarItem> items;
}
