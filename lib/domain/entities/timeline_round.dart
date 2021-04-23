import 'package:flutter_scroll_test/domain/enums/stock_interval.dart';
import 'package:flutter_scroll_test/presentation/widgets/constants.dart';

class TimelineRound {
  final StockInterval stockInterval;

  late final int _milliseconds;
  late final int _roundingNumber;
  late final bool _doubleRounding;

  TimelineRound(this.stockInterval) {
    _init();
  }

  void _init() {
    switch (stockInterval) {
      case StockInterval.oneMin:
        _milliseconds = kOneMinStep.inMilliseconds;
        _roundingNumber = Duration.millisecondsPerMinute;
        _doubleRounding = true;
        break;

      case StockInterval.threeMin:
        _milliseconds = kThreeMinStep.inMilliseconds;
        _roundingNumber = Duration.millisecondsPerHour;
        _doubleRounding = false;
        break;

      case StockInterval.fiveMin:
        // TODO: разбираюсь с округлением до 1:30
        _milliseconds = kFiveMinStep.inMilliseconds;
        _roundingNumber = Duration.millisecondsPerMinute;
        _doubleRounding = false;
        break;

      case StockInterval.tenMin:
        _milliseconds = kTenMinStep.inMilliseconds;
        _roundingNumber = Duration.millisecondsPerHour;
        _doubleRounding = false;
        break;

      case StockInterval.fifteenMin:
        _milliseconds = kFifteenMinStep.inMilliseconds;
        _roundingNumber = Duration.millisecondsPerHour;
        _doubleRounding = false;
        break;

      case StockInterval.thirtyMin:
        _milliseconds = kThreeMinStep.inMilliseconds;
        _roundingNumber = Duration.millisecondsPerHour;
        _doubleRounding = false;
        break;

      case StockInterval.hour:
        _milliseconds = kHourStep.inMilliseconds;
        _roundingNumber = Duration.millisecondsPerDay;
        _doubleRounding = false;
        break;

      case StockInterval.day:
        _milliseconds = kDayStep.inMilliseconds;
        _doubleRounding = false;
        break;

      case StockInterval.week:
        _milliseconds = kWeekStep.inMilliseconds;
        _roundingNumber = Duration.millisecondsPerDay * 30;
        _doubleRounding = false;
        break;

      case StockInterval.month:
        _milliseconds = kMonthStep.inMilliseconds;
        _roundingNumber = Duration.millisecondsPerDay * 365;
        _doubleRounding = false;
        break;
    }
  }

  int get inMilliseconds => _milliseconds;

  int round(double value) {
    final factor = _doubleRounding ? 5 : 10;
    final time = value / _roundingNumber;
    final rounded = (time / factor).round() * factor;
    return rounded * _roundingNumber;
  }
}
