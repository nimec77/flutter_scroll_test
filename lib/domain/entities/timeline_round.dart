import 'package:flutter_scroll_test/domain/enums/stock_interval.dart';
import 'package:flutter_scroll_test/presentation/widgets/constants.dart';

class TimelineRound {
  final StockInterval stockInterval;

  late final int _milliseconds;
  late final int _roundingNumber;

  TimelineRound(this.stockInterval) {
    _init();
  }

  int get inMilliseconds => _milliseconds;

  int round(double value) {
    final time = value / _roundingNumber;
    final rounded = (time * 0.1).round() * 10;
    return rounded * _roundingNumber;
  }

  void _init() {
    switch (stockInterval) {
      case StockInterval.oneMin:
        _milliseconds = kOneMinStep.inMilliseconds;
        _roundingNumber = Duration.millisecondsPerMinute * 15;
        break;

      case StockInterval.threeMin:
        _milliseconds = kThreeMinStep.inMilliseconds;
        _roundingNumber = Duration.millisecondsPerHour;
        break;

      case StockInterval.fiveMin:
        _milliseconds = kFiveMinStep.inMilliseconds;
        _roundingNumber = Duration.millisecondsPerHour ~/ 2;
        break;

      case StockInterval.tenMin:
        _milliseconds = kTenMinStep.inMilliseconds;
        _roundingNumber = Duration.millisecondsPerHour * 3;
        break;

      case StockInterval.fifteenMin:
        _milliseconds = kFifteenMinStep.inMilliseconds;
        _roundingNumber = Duration.millisecondsPerHour;
        break;

      case StockInterval.thirtyMin:
        _milliseconds = kThreeMinStep.inMilliseconds;
        _roundingNumber = Duration.millisecondsPerHour;
        break;

      case StockInterval.hour:
        _milliseconds = kHourStep.inMilliseconds;
        _roundingNumber = Duration.millisecondsPerDay;
        break;

      case StockInterval.day:
        _milliseconds = kDayStep.inMilliseconds;
        break;

      case StockInterval.week:
        _milliseconds = kWeekStep.inMilliseconds;
        _roundingNumber = Duration.millisecondsPerDay * 30;
        break;

      case StockInterval.month:
        _milliseconds = kMonthStep.inMilliseconds;
        _roundingNumber = Duration.millisecondsPerDay * 365;
        break;
    }
  }
}
