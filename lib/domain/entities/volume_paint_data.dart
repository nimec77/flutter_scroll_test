import 'package:flutter/cupertino.dart';
import 'package:flutter_scroll_test/presentation/widgets/constants.dart';

import 'volume_range.dart';

class VolumePaintData {
  final VolumeRange volumeRange;
  final double height;
  final double stockPaddingBottom;
  final double stockPaddingTop;
  late final double _volumePerPixel;
  late final double _minValue;
  late final double _maxValue;

  VolumePaintData({
    required this.volumeRange,
    required this.height,
    this.stockPaddingBottom = kStockPaddingBottom,
    this.stockPaddingTop = kStockPaddingTop,
  }) {
    _volumePerPixel = volumeRange.size / height;
    _minValue = volumeRange.minVolume - heightToVolume(stockPaddingBottom);
    _maxValue = volumeRange.maxVolume + heightToVolume(stockPaddingTop);
  }

  double get volumePerPixel => _volumePerPixel;

  double get minValue => _minValue;

  double heightToVolume(double height) => height * _volumePerPixel;

  @override
  bool operator ==(Object other) {
    return other is VolumePaintData && other.volumeRange == volumeRange && other.height == height;
  }

  @override
  int get hashCode => hashValues(volumeRange, height);
}
