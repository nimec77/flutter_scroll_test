import 'package:flutter/material.dart';
import 'package:flutter_scroll_test/domain/entities/volume_paint_data.dart';

import 'constants.dart';

class AxisYWidget extends StatelessWidget {
  final VolumePaintData volumePaintData;

  const AxisYWidget({Key? key, required this.volumePaintData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _AxisYWidgetPainter(volumePaintData),
      isComplex: true,
    );
  }
}

class _AxisYWidgetPainter extends CustomPainter {
  final VolumePaintData volumePaintData;

  _AxisYWidgetPainter(this.volumePaintData);

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
        Offset(width + 4, segment.point),
        paint,
      );
      final textSpan = TextSpan(text: segment.value, style: kTextAxisColor);
      final textPainter = TextPainter(text: textSpan, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
      textPainter.layout(maxWidth: kIndentationX);
      textPainter.paint(canvas, Offset(width + 8, segment.point - textPainter.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return !identical(oldDelegate, this) ||
        oldDelegate is! _AxisYWidgetPainter ||
        oldDelegate.volumePaintData != volumePaintData;
  }
}
