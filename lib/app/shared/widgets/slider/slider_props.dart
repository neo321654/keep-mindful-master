class AppSliderProps {
  AppSliderProps({
    required this.value,
    required this.onChange,
    this.divisions,
    this.min = 0,
    this.max = 100,
  });
  final double? value;
  final void Function(double)? onChange;
  final int? divisions;
  final double min;
  final double max;
}
