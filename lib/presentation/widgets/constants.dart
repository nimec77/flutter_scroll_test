import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const double kIndentationY = 30.0;
const double kIndentationX = 65.0;
const double kStepY = 50;
const double kStepX = 100;
const double kStockPaddingLeft = 20;
const double kStockPaddingTop = 20;
const double kStockPaddingRight = 20;
const double kStockPaddingBottom = 20;
const Color kLineColor = Colors.white12;
const Color kAxisColor = Colors.white60;
const TextStyle kTextAxisColor = TextStyle(color: Colors.white60, fontSize: 11);
const int kMaxNumbers = 7;
const Duration kOneMinStep = Duration(minutes: 15);
const Duration kThreeMinStep = Duration(hours: 1);
const Duration kFiveMinStep = Duration(hours: 1, minutes: 30);
const Duration kTenMinStep = Duration(hours: 3);
const Duration kFifteenMinStep = Duration(hours: 6);
const Duration kHourStep = Duration(days: 1);
const Duration kDayStep = Duration(days: 30);
const Duration kWeekStep = Duration(days: 3 * 30);
const Duration kMonthStep = Duration(days: 2 * 365);
final DateFormat kHourMinuteFormat = DateFormat.jm();
