import 'package:flutter/material.dart';

class AxisWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _AxisWidgetPainter(),
    );
  }
}

class _AxisWidgetPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()..color = Colors.white12;
    final axisPaint = Paint()..color = Colors.white70;

    final height = size.height - 30;
    // final width = size.width - 50;
    final width = size.width;

    for (double y = 0; y < height; y += 50) {
      canvas.drawLine(
        Offset(0, y),
        Offset(width, y),
        linePaint,
      );
      // final textSpan = TextSpan(text: '$y', style: TextStyle(color: Colors.white70, fontSize: 10));
      // final textPainter = TextPainter(text: textSpan, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
      // textPainter.layout(maxWidth: 50);
      // textPainter.paint(canvas, Offset(width + 4, y - textPainter.height / 2));
    }
    for (double x = 0; x <= width; x += 100) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, height),
        linePaint,
      );
      final textSpan = TextSpan(text: '${width - x}', style: const TextStyle(color: Colors.white70, fontSize: 10));
      final textPainter = TextPainter(text: textSpan, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
      textPainter.layout(maxWidth: 95);
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, height + 4));
    }

    // canvas.drawLine(
    //   Offset(width, 0),
    //   Offset(width, height),
    //   axisPaint,
    // );
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
