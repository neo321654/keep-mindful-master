class DropdownItemProps {
  const DropdownItemProps({required this.title, required this.value});

  final String value;
  final String title;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is DropdownItemProps &&
        other.value == value &&
        other.title == title;
  }

  @override
  int get hashCode => Object.hash(value, title);
}
