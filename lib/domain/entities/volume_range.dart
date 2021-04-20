
import 'package:freezed_annotation/freezed_annotation.dart';

part 'volume_range.freezed.dart';

@freezed
abstract class VolumeRange with _$VolumeRange {
  @Assert('minVolume <= maxVolume', 'the maximum volume must be greater than the minimum volume')
  const factory VolumeRange({
    required final double minVolume,
    required final double maxVolume,
  }) = _VolumeRange;
}