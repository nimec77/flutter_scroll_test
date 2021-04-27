import 'dart:ui';

class DataPoint {
  final double point;
  final String value;

  const DataPoint({required this.point, required this.value});

  @override
  bool operator ==(Object other) {
    return identical(other, this) || other is DataPoint && other.point == point && other.value == value;
  }

  @override
  int get hashCode => hashValues(point, value);

  @override
  String toString() => 'DataPoint(point:$point, data:$value)';
}
