import 'package:flutter/material.dart';

import 'constants.dart';

class AxisXWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _AxisXWidgetPainter(),
    );
  }
}

class _AxisXWidgetPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()..color = kLineColor;
    final axisPaint = Paint()..color = kAxisColor;

    final height = size.height - kIndentationY;
    final width = size.width;

    for (double y = height; y >= 0; y -= kStepByY) {
      canvas.drawLine(
        Offset(0, y),
        Offset(width, y),
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
    return true;
  }
}
