import 'package:flutter/material.dart';
import 'package:flutter_scroll_test/domain/entities/volume_paint_data.dart';

import 'constants.dart';

class AxisXWidget extends StatelessWidget {
  final VolumePaintData volumePaintData;

  const AxisXWidget({Key? key, required this.volumePaintData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _AxisXWidgetPainter(volumePaintData),
    );
  }
}

class _AxisXWidgetPainter extends CustomPainter {
  final VolumePaintData volumePaintData;

  _AxisXWidgetPainter(this.volumePaintData);

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()..color = kLineColor;
    final axisPaint = Paint()..color = kAxisColor;

    final height = volumePaintData.paintHeight;

    final width = size.width;

    for (final segment in volumePaintData.segments) {
      canvas.drawLine(
        Offset(0, segment.point),
        Offset(width, segment.point),
        linePaint,
      );
    }
    for (double x = width; x >= 0; x -= kStepByX) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, height),
        linePaint,
      );
      final textSpan = TextSpan(text: '${width - x}', style: kTextAxisColor);
      final textPainter = TextPainter(text: textSpan, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
      textPainter.layout(maxWidth: kStepByX - 5);
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, height + 4));
    }

    canvas.drawLine(
      Offset(0, height),
      Offset(width, height),
      axisPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is! _AxisXWidgetPainter || oldDelegate.volumePaintData != volumePaintData;
  }
}
