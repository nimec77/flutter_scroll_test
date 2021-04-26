import 'package:flutter_scroll_test/domain/enums/stock_interval.dart';
import 'package:flutter_scroll_test/presentation/widgets/constants.dart';

class TimelineRound {
  final StockInterval stockInterval;

  late final int _milliseconds;

  TimelineRound(this.stockInterval) {
    _init();
  }

  int get inMilliseconds => _milliseconds;

  int round(double value) {
    final time = value / _milliseconds;
    return time.round() * _milliseconds;
  }

  void _init() {
    switch (stockInterval) {
      case StockInterval.oneMin:
        _milliseconds = kOneMinStep.inMilliseconds;
        break;

      case StockInterval.threeMin:
        _milliseconds = kThreeMinStep.inMilliseconds;
        break;

      case StockInterval.fiveMin:
        _milliseconds = kFiveMinStep.inMilliseconds;
        break;

      case StockInterval.tenMin:
        _milliseconds = kTenMinStep.inMilliseconds;
        break;

      case StockInterval.fifteenMin:
        _milliseconds = kFifteenMinStep.inMilliseconds;
        break;

      case StockInterval.thirtyMin:
        _milliseconds = kThreeMinStep.inMilliseconds;
        break;

      case StockInterval.hour:
        _milliseconds = kHourStep.inMilliseconds;
        break;

      case StockInterval.day:
        _milliseconds = kDayStep.inMilliseconds;
        break;

      case StockInterval.week:
        _milliseconds = kWeekStep.inMilliseconds;
        break;

      case StockInterval.month:
        _milliseconds = kMonthStep.inMilliseconds;
        break;
    }
  }
}
