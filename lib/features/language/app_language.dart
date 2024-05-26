import 'dart:ui';

class AppLanguage {
  const AppLanguage({required this.name, required this.locale});
  final String name;
  final Locale locale;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is AppLanguage && other.name == name && other.locale == locale;
  }

  @override
  int get hashCode => Object.hash(name, locale);
}
