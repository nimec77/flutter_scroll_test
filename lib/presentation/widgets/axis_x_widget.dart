import 'package:flutter/material.dart';
import 'package:flutter_scroll_test/domain/entities/timeline_paint_data.dart';
import 'package:flutter_scroll_test/domain/entities/volume_paint_data.dart';

import '../constants.dart';

class AxisXWidget extends StatelessWidget {
  final TimelinePaintData timelinePaintData;
  final VolumePaintData volumePaintData;

  const AxisXWidget({Key? key, required this.timelinePaintData, required this.volumePaintData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _AxisXWidgetPainter(timelinePaintData, volumePaintData),
      isComplex: true,
    );
  }
}

class _AxisXWidgetPainter extends CustomPainter {
  final TimelinePaintData timelinePaintData;
  final VolumePaintData volumePaintData;

  _AxisXWidgetPainter(this.timelinePaintData, this.volumePaintData);

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()..color = kLineColor;
    final axisPaint = Paint()..color = kAxisColor;

    final height = volumePaintData.paintHeight;

    final width = timelinePaintData.width;

    for (final segmentByY in volumePaintData.segmentsByY) {
      canvas.drawLine(
        Offset(0, segmentByY.point),
        Offset(width, segmentByY.point),
        linePaint,
      );
    }
    for (final segmentByX in timelinePaintData.segmentsByX) {
      canvas.drawLine(
        Offset(segmentByX.point, 0),
        Offset(segmentByX.point, height),
        linePaint,
      );
      canvas.drawLine(
        Offset(segmentByX.point, height),
        Offset(segmentByX.point, height + kHatchWidth),
        axisPaint,
      );
      final textSpan = TextSpan(text: segmentByX.value, style: kTextAxisStyle);
      final textPainter = TextPainter(text: textSpan, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
      textPainter.layout(maxWidth: kStepX - 4);
      textPainter.paint(canvas, Offset(segmentByX.point - textPainter.width / 2, height + kHatchWidth + 4));
    }

    canvas.drawLine(
      Offset(0, height),
      Offset(width, height),
      axisPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is _AxisXWidgetPainter &&
            other.volumePaintData == volumePaintData &&
            other.timelinePaintData == timelinePaintData;
  }

  @override
  int get hashCode => hashValues(timelinePaintData, volumePaintData);
}
