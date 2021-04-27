import 'dart:collection';
import 'dart:ui';

import 'package:flutter_scroll_test/domain/entities/timeline_round.dart';
import 'package:flutter_scroll_test/domain/enums/stock_interval.dart';
import 'package:flutter_scroll_test/presentation/constants.dart';

import 'data_point.dart';

class TimelinePaintData {
  final DateTime startTime;
  final StockInterval stockInterval;
  final double width;
  final double stepX;
  final double stockPaddingRight;

  late final TimelineRound _timelineRound;
  late final double _width;
  late final double _millisecondsPerPixel;
  late final UnmodifiableListView<DataPoint> _segments;
  late final double _widthInMilliseconds;
  late int _startTimeInMilliseconds;

  TimelinePaintData({
    required this.startTime,
    required this.stockInterval,
    required this.width,
    this.stepX = kStepX,
    this.stockPaddingRight = kStockPaddingRight,
  }) {
    _width = width - stockPaddingRight;
    _timelineRound = TimelineRound(stockInterval);
    _millisecondsPerPixel = _timelineRound.inMilliseconds / stepX;
    _segments = _calcSegments();
  }

  double get paintWidth => _width;

  UnmodifiableListView<DataPoint> get segmentsByX => _segments;

  DateTime dxToDateTime(double dx) {
    final dxInMilliseconds = _widthToMilliseconds(dx);
    final time = DateTime.fromMillisecondsSinceEpoch(
        (_startTimeInMilliseconds - _widthInMilliseconds + dxInMilliseconds).toInt(), isUtc: true);
    // print('dx:$dx, time:$time');
    return time;
  }

  UnmodifiableListView<DataPoint> _calcSegments() {
    final List<DataPoint> result = [];
    final stepInMilliseconds = _widthToMilliseconds(stepX);
    _startTimeInMilliseconds = _timelineRound.round(startTime.millisecondsSinceEpoch.toDouble());
    if (_startTimeInMilliseconds < startTime.millisecondsSinceEpoch) {
      _startTimeInMilliseconds += stepInMilliseconds.toInt();
    }
    _widthInMilliseconds = _widthToMilliseconds(_width);
    for (double millisecondsX = _widthInMilliseconds; millisecondsX >= 0; millisecondsX -= stepInMilliseconds) {
      final time = DateTime.fromMillisecondsSinceEpoch(
          (_startTimeInMilliseconds - _widthInMilliseconds + millisecondsX).toInt(),
          isUtc: true);
      result.add(DataPoint(point: _millisecondsToWidth(millisecondsX), value: kHourMinuteFormat.format(time)));
    }
    return UnmodifiableListView(result);
  }

  double _widthToMilliseconds(double width) => width * _millisecondsPerPixel;

  double _millisecondsToWidth(double milliseconds) => milliseconds / _millisecondsPerPixel;

  @override
  bool operator ==(Object other) {
    return identical(other, this) || other is TimelinePaintData && other.startTime == startTime && other.width == width;
  }

  @override
  int get hashCode => hashValues(startTime, width);
}
