class Alarm {
  Alarm(
      {required this.time,
      required this.createdAt,
      this.name = '',
      this.isActive = true});

  DateTime time;
  String name;
  bool isActive;
  DateTime createdAt;

  Alarm copyWith({DateTime? time, String? name, bool? isActive}) {
    return Alarm(
        time: time ?? this.time,
        name: name ?? this.name,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Alarm &&
        other.time == time &&
        other.name == name &&
        other.isActive == isActive &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => Object.hash(time, name, isActive, createdAt);
}
