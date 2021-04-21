import 'dart:ui';

class VolumeRange {
  final double minVolume;
  final double maxVolume;

  const VolumeRange({required this.minVolume, required this.maxVolume})
      : assert(minVolume < maxVolume, 'The maximum volume must be greater than the minimum volume');

  double get size => maxVolume - minVolume;

  @override
  bool operator ==(Object other) {
    return other is VolumeRange && other.maxVolume == maxVolume && other.minVolume == minVolume;
  }

  @override
  int get hashCode => hashValues(minVolume, maxVolume);

  @override
  String toString() => 'VolumeRange(minVolume:$minVolume, maxVolume:$maxVolume)';
}
