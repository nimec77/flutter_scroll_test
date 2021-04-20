import 'package:flutter/material.dart';
import 'package:flutter_scroll_test/domain/entities/volume_range.dart';

import 'constants.dart';

class AxisYWidget extends StatelessWidget {
  final VolumeRange volumeRange;

  const AxisYWidget({Key? key, required this.volumeRange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _AxisYWidgetPainter(volumeRange),
    );
  }
}

class _AxisYWidgetPainter extends CustomPainter {
  final VolumeRange volumeRange;

  _AxisYWidgetPainter(this.volumeRange);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = kAxisColor;

    final height = size.height - kIndentationY;
    final width = size.width - kIndentationX;
    final volumePerPixel =
        (volumeRange.maxVolume - volumeRange.minVolume) / (height - kStockPaddingBottom - kStockPaddingTop);
    final minVolume = volumeRange.minVolume - kStockPaddingBottom * volumePerPixel;

    canvas.drawLine(
      Offset(width, 0),
      Offset(width, height),
      paint,
    );

    for (double y = height; y >= 0; y -= kStepByY) {
      canvas.drawLine(
        Offset(width, y),
        Offset(width + 4, y),
        paint,
      );
      final volume = (height - y) * volumePerPixel + minVolume;
      final value = volume.toStringAsFixed(0);
      final textSpan = TextSpan(text: value, style: kTextAxisColor);
      final textPainter = TextPainter(text: textSpan, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
      textPainter.layout(maxWidth: kIndentationX);
      textPainter.paint(canvas, Offset(width + 8, y - textPainter.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is! _AxisYWidgetPainter) {
      return true;
    }
    return oldDelegate.volumeRange != volumeRange;
  }
}
