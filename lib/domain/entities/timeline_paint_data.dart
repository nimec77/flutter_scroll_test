import 'dart:collection';
import 'dart:ui';

import 'package:flutter_scroll_test/domain/enums/stock_interval.dart';
import 'package:flutter_scroll_test/presentation/widgets/constants.dart';

import 'data_point.dart';

class TimelinePaintData {
  final DateTime startTime;
  final StockInterval stockInterval;
  final double width;
  final double stepX;
  final double stockPaddingRight;

  late final int _intervalMilliseconds;
  late final double _width;
  late final double _millisecondsPerPixel;
  late final UnmodifiableListView<DataPoint> _segments;

  TimelinePaintData({
    required this.startTime,
    required this.stockInterval,
    required this.width,
    this.stepX = kStepX,
    this.stockPaddingRight = kStockPaddingRight,
  }) {
    _width = width - stockPaddingRight;
    _intervalMilliseconds = _stockIntervalToTickets(stockInterval);
    _millisecondsPerPixel = _intervalMilliseconds / stepX;
    _segments = _calcSegments();
  }

  double get paintWidth => _width;

  UnmodifiableListView<DataPoint> get segmentsByX => _segments;

  int _stockIntervalToTickets(StockInterval stockInterval) {
    switch (stockInterval) {
      case StockInterval.oneMin:
        return kOneMinStep.inMilliseconds;

      case StockInterval.threeMin:
        return kThreeMinStep.inMilliseconds;

      case StockInterval.fiveMin:
        return kFiveMinStep.inMilliseconds;

      case StockInterval.tenMin:
        return kTenMinStep.inMilliseconds;

      case StockInterval.fifteenMin:
        return kFifteenMinStep.inMilliseconds;

      case StockInterval.thirtyMin:
        return kThreeMinStep.inMilliseconds;

      case StockInterval.hour:
        return kHourStep.inMilliseconds;

      case StockInterval.day:
        return kDayStep.inMilliseconds;

      case StockInterval.week:
        return kWeekStep.inMilliseconds;

      case StockInterval.month:
        return kMonthStep.inMilliseconds;
    }
  }

  UnmodifiableListView<DataPoint> _calcSegments() {
    final List<DataPoint> result = [];
    final millisecondsStep =  _widthToMilliseconds(stepX);
    final millisecondsWidth = _toBeautiful(_widthToMilliseconds(width));
    for (double millisecondsX = millisecondsWidth; millisecondsX >= 0; millisecondsX -= millisecondsStep) {
      final time = DateTime.fromMillisecondsSinceEpoch(
          _toBeautiful(startTime.millisecondsSinceEpoch - millisecondsX).toInt());
      result.add(DataPoint(point: _millisecondsToWidth(millisecondsX), value: kHourMinuteFormat.format(time)));
    }
    return UnmodifiableListView(result);
  }

  double _toBeautiful(double value) {
    final minutes = value / Duration.millisecondsPerMinute;
    final rounded = (minutes * 0.2).round() * 5;
    return (rounded * Duration.millisecondsPerMinute).toDouble();
  }

  double _widthToMilliseconds(double width) => width * _millisecondsPerPixel;

  double _millisecondsToWidth(double milliseconds) => milliseconds / _millisecondsPerPixel;

  @override
  bool operator ==(Object other) {
    return other is TimelinePaintData && other.startTime == startTime && other.width == width;
  }

  @override
  int get hashCode => hashValues(startTime, width);
}
