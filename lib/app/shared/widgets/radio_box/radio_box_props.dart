class RadioBoxProps<T> {
  const RadioBoxProps({required this.value, this.groupValue, this.onPressed});
  final T value;
  final T? groupValue;
  final void Function(T mode)? onPressed;
}
