import 'dart:collection';
import 'dart:math';
import 'dart:ui';

import 'package:flutter_scroll_test/domain/entities/data_point.dart';
import 'package:flutter_scroll_test/presentation/constants.dart';

import 'volume_range.dart';

class VolumePaintData {
  final VolumeRange volumeRange;
  final double height;
  final int maxNumbers;
  final double stepY;
  final double stockPaddingBottom;
  final double stockPaddingTop;
  final double indentationY;

  late final double _height;
  late final double _volumePerPixel;
  late final double _volumeHeight;
  late final double _minValue;
  late final UnmodifiableListView<DataPoint> _segments;
  late final int _fixed;

  VolumePaintData({
    required this.volumeRange,
    required this.height,
    this.maxNumbers = kMaxNumbers,
    this.stepY = kStepY,
    this.stockPaddingBottom = kStockPaddingBottom,
    this.stockPaddingTop = kStockPaddingTop,
    this.indentationY = kIndentationY,
  }) {
    _height = height - indentationY;
    _volumePerPixel = volumeRange.size / (_height - stockPaddingBottom - stockPaddingTop);
    _fixed = _getFixed(volumeRange.maxVolume);
    _volumeHeight = double.parse(_toBeautiful(_heightToVolume(_height), _fixed));
    _minValue = double.parse(_toBeautiful(volumeRange.minVolume - _heightToVolume(stockPaddingBottom), _fixed));
    _segments = _calcSegments();
  }

  double get paintHeight => _height;

  UnmodifiableListView<DataPoint> get segmentsByY => _segments;

  String heightToVolume(double height) {
    final volume = _volumeHeight - _heightToVolume(height) + _minValue;
    return volume.toStringAsFixed(_fixed);
  }

  UnmodifiableListView<DataPoint> _calcSegments() {
    final List<DataPoint> result = [];
    // final maxValue = double.parse(_toBeautiful(volumeRange.maxVolume + heightToVolume(stockPaddingTop), fixed));
    final volumeStep = double.parse(_toBeautiful(_heightToVolume(stepY), _fixed));
    for (double volumeY = _volumeHeight; volumeY >= 0; volumeY -= volumeStep) {
      final volume = _volumeHeight - volumeY + _minValue;
      result.add(DataPoint(point: _volumeToHeight(volumeY), value: volume.toStringAsFixed(_fixed)));
    }
    return UnmodifiableListView(result);
  }

  double _heightToVolume(double height) => height * _volumePerPixel;

  double _volumeToHeight(double volume) => volume / _volumePerPixel;

  String _toBeautiful(double value, int fixed) {
    final entry = _cutToMaxLength(value, fixed);
    final integer = (entry.value * 0.2).round() * 5;
    final divider = pow(10, entry.key);

    return (integer / divider).toStringAsFixed(fixed);
  }

  int _getFixed(double value) {
    int fixed = maxNumbers - 1;
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

  MapEntry<int, int> _cutToMaxLength(double value, int fixed) {
    var str = value.toStringAsFixed(fixed);
    if (str.length > maxNumbers + 1) {
      str = str.substring(0, maxNumbers);
    }
    final lst = str.split('.');
    final divider = lst.length > 1 ? lst[1].length : 0;

    return MapEntry(divider, int.parse(lst.join()));
  }

  @override
  bool operator ==(Object other) {
    return identical(other, this) ||
        other is VolumePaintData && other.volumeRange == volumeRange && other.height == height;
  }

  @override
  int get hashCode => hashValues(volumeRange, height);
}
