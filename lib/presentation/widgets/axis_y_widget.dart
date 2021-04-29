import 'package:flutter/material.dart';
import 'package:flutter_scroll_test/domain/entities/volume_paint_data.dart';

import '../constants.dart';

class AxisYWidget extends StatelessWidget {
  final VolumePaintData volumePaintData;
  final Offset pricePosition;

  const AxisYWidget({Key? key, required this.volumePaintData, required this.pricePosition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _AxisYWidgetPainter(volumePaintData, pricePosition),
    );
  }
}

class _AxisYWidgetPainter extends CustomPainter {
  final VolumePaintData volumePaintData;
  final Offset pricePosition;

  _AxisYWidgetPainter(this.volumePaintData, this.pricePosition);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = kAxisColor;

    final height = volumePaintData.paintHeight;
    final width = size.width - kIndentationX;

    canvas.drawLine(
      Offset(width, 0),
      Offset(width, height),
      paint,
    );

    for (final segment in volumePaintData.segmentsByY) {
      canvas.drawLine(
        Offset(width, segment.point),
        Offset(width + kHatchWidth, segment.point),
        paint,
      );
      final textSpan = TextSpan(text: segment.value, style: kTextAxisStyle);
      final textPainter = TextPainter(text: textSpan, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
      textPainter.layout(maxWidth: kIndentationX);
      textPainter.paint(canvas, Offset(width + kHatchWidth * 2, segment.point - textPainter.height / 2));
    }
    if (pricePosition != Offset.zero) {
      _drawPrice(canvas, width);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) {
    return identical(other, this) ||
        other is _AxisYWidgetPainter &&
            other.volumePaintData == volumePaintData &&
            other.pricePosition == pricePosition;
  }

  @override
  int get hashCode => hashValues(volumePaintData, pricePosition);

  void _drawPrice(Canvas canvas, double dx) {
    final paint = Paint()..color = kTextPriceBackgroundColor;
    final textSpan = TextSpan(text: volumePaintData.heightToVolume(pricePosition.dy), style: kTextPriceStyle);
    final textPainter = TextPainter(text: textSpan, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    textPainter.layout(maxWidth: kIndentationX);
    canvas.drawRect(
      Rect.fromLTWH(
        dx,
        pricePosition.dy - kTextPricePadding - textPainter.height / 2,
        textPainter.width + 2 * kTextPricePadding + kHatchWidth,
        textPainter.height + 2 * kTextPricePadding,
      ),
      // Rect.fromCenter(
      //   center: Offset(dx + (textPainter.width + kHatchWidth) / 2, pricePosition.dy),
      //   width: textPainter.width + 2 * kTextPricePadding + kHatchWidth,
      //   height: textPainter.height + 2 * kTextPricePadding,
      // ),
      paint,
    );
    final hatchPaint = Paint()..color = kAxisColor;
    canvas.drawLine(
      Offset(dx, pricePosition.dy),
      Offset(dx + kHatchWidth, pricePosition.dy),
      hatchPaint,
    );
    textPainter.paint(canvas, Offset(dx + kHatchWidth * 2, pricePosition.dy - textPainter.height / 2));
  }
}
