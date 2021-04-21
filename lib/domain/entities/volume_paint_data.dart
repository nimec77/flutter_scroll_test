import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_scroll_test/domain/entities/data_point.dart';
import 'package:flutter_scroll_test/presentation/widgets/constants.dart';

import 'volume_range.dart';

class VolumePaintData {
  final VolumeRange volumeRange;
  final double height;
  final double stockPaddingBottom;
  final double stockPaddingTop;
  late final double _height;
  late final double _volumePerPixel;
  late final double _minValue;
  late final double _maxValue;
  late final double _volumeStep;
  late final List<DataPoint> _segments;

  VolumePaintData({
    required this.volumeRange,
    required this.height,
    this.stockPaddingBottom = kStockPaddingBottom,
    this.stockPaddingTop = kStockPaddingTop,
  }) {
    _height = height - kIndentationY;
    _volumePerPixel = volumeRange.size / (_height - kStockPaddingBottom - kStockPaddingTop);
    _minValue = double.parse(_toBeautiful(volumeRange.minVolume - heightToVolume(stockPaddingBottom)));
    _maxValue = double.parse(_toBeautiful(volumeRange.maxVolume + heightToVolume(stockPaddingTop)));
    _volumeStep = double.parse(_toBeautiful(heightToVolume(kStepByY)));
    _segments = _calcSegments();
  }

  double get paintHeight => _height;

  double get volumePerPixel => _volumePerPixel;

  double get minValue => _minValue;

  List<DataPoint> get segments => _segments;

  double heightToVolume(double height) => height * _volumePerPixel;

  double volumeToHeight(double volume) => volume / _volumePerPixel;

  List<DataPoint> _calcSegments() {
    final List<DataPoint> result = [];
    final volumeHeight = double.parse(_toBeautiful(heightToVolume(_height)));
    debugPrint('volumeHeight:$volumeHeight, volumeStep:$_volumeStep');
    for (double y = _height; y >= 0; y -= kStepByY) {
      final volume = heightToVolume(_height - y) + _minValue;
      result.add(DataPoint(point: volumeToHeight(volume), value: _toBeautiful(volume)));
    }
    return result;
  }

  String _toBeautiful(double value) {
    final fixed = _getFixed(value);
    final entry = _cutToMaxLength(value, fixed, kMaximumNumberLength);
    final integer = (entry.value * 0.2).round() * 5;
    final divider = pow(10, entry.key);

    return (integer / divider).toStringAsFixed(fixed);
  }

  int _getFixed(double value) {
    int fixed = kMaximumNumberLength - 1;
    if (value > 10000) {
      fixed = 0;
    } else if (value > 1000) {
      fixed = 1;
    } else if (value > 100) {
      fixed = 2;
    } else if (value > 10) {
      fixed = 3;
    } else if (value > 1) {
      fixed = 4;
    }

    return fixed;
  }

  MapEntry<int, int> _cutToMaxLength(double value, int fixed, int maxLength) {
    var str = value.toStringAsFixed(fixed);
    if (str.length > maxLength + 1) {
      str = str.substring(0, maxLength);
    }
    final lst = str.split('.');
    final divider = lst.length > 1 ? lst[1].length : 0;

    return MapEntry(divider, int.parse(lst.join()));
  }

  @override
  bool operator ==(Object other) {
    return other is VolumePaintData && other.volumeRange == volumeRange && other.height == height;
  }

  @override
  int get hashCode => hashValues(volumeRange, height);
}
