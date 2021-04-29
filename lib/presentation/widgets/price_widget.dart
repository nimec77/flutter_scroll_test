import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_scroll_test/domain/entities/timeline_paint_data.dart';
import 'package:flutter_scroll_test/domain/entities/volume_paint_data.dart';
import 'package:flutter_scroll_test/presentation/constants.dart';

class PriceWidget extends StatefulWidget {
  final TimelinePaintData timelinePaintData;
  final VolumePaintData volumePaintData;
  final ValueNotifier<Offset> priceNotifier;

  const PriceWidget({
    Key? key,
    required this.timelinePaintData,
    required this.volumePaintData,
    required this.priceNotifier,
  }) : super(key: key);

  @override
  _PriceWidgetState createState() => _PriceWidgetState();
}

class _PriceWidgetState extends State<PriceWidget> {
  late Offset position;

  @override
  void initState() {
    super.initState();
    position = Offset.zero;
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.volumePaintData.paintHeight;
    final width = widget.timelinePaintData.paintWidth;
    return MouseRegion(
      onEnter: (details) {
        if (details.localPosition.dx < width && details.localPosition.dy < height) {
          setState(() {
            position = details.localPosition;
            widget.priceNotifier.value = position;
          });
        }
      },
      onHover: (details) {
        if (details.localPosition.dx < width && details.localPosition.dy < height) {
          setState(() {
            position = details.localPosition;
            widget.priceNotifier.value = position;
          });
        }
      },
      onExit: (details) {
        setState(() {
          position = Offset.zero;
          widget.priceNotifier.value = position;
        });
      },
      child: CustomPaint(
        painter: _PriceWidgetPainter(widget.timelinePaintData, height, position),
        isComplex: true,
      ),
    );
  }
}

class _PriceWidgetPainter extends CustomPainter {
  final TimelinePaintData timelinePaintData;
  final double height;
  final Offset position;

  _PriceWidgetPainter(this.timelinePaintData, this.height, this.position);

  @override
  void paint(Canvas canvas, Size size) {
    if (position == Offset.zero) {
      return;
    }
    _drawDashedLines(canvas, size);
    _drawCross(canvas);
    _drawPrice(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) {
    return identical(other, this) ||
        other is _PriceWidgetPainter &&
            other.timelinePaintData == timelinePaintData &&
            other.height == height &&
            other.position == position;
  }

  @override
  int get hashCode => hashValues(timelinePaintData, height, position);

  void _drawDashedLines(Canvas canvas, Size size) {
    final dashedLinePaint = Paint()..color = kDashColor;
    final step = kDashWidth + kDashSpace;

    for (double x = size.width; x > kDashWidth; x -= step) {
      canvas.drawLine(Offset(x, position.dy), Offset(x - kDashWidth, position.dy), dashedLinePaint);
    }

    for (double y = height; y > kDashWidth; y -= step) {
      canvas.drawLine(Offset(position.dx, y), Offset(position.dx, y - kDashWidth), dashedLinePaint);
    }
  }

  void _drawCross(Canvas canvas) {
    final crossPath = Path();

    crossPath
      ..moveTo(position.dx - kCrossSize / 2 - kCrossSubstrateSize / 2, position.dy)
      ..lineTo(position.dx + kCrossSize / 2 + kCrossSubstrateSize / 2, position.dy)
      ..moveTo(position.dx, position.dy - kCrossSize / 2 - kCrossSubstrateSize)
      ..lineTo(position.dx, position.dy + kCrossSize / 2 + kCrossSubstrateSize)
      ..close();

    final crossPaint = Paint()
      ..color = kCrossSubstrateColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = kCrossLineWidth + kCrossSubstrateSize;
    canvas.drawPath(crossPath, crossPaint);

    final paint = Paint()
      ..color = kCrossColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = kCrossLineWidth;

    final path = Path();
    path
      ..moveTo(position.dx - kCrossSize / 2, position.dy)
      ..lineTo(position.dx + kCrossSize / 2, position.dy)
      ..moveTo(position.dx, position.dy - kCrossSize / 2)
      ..lineTo(position.dx, position.dy + kCrossSize / 2)
      ..close();
    canvas.drawPath(path, paint);
  }

  void _drawPrice(Canvas canvas) {
    final paint = Paint()..color = kTextPriceBackgroundColor;
    final axisPaint = Paint()..color = kAxisColor;
    final textSpan =
        TextSpan(text: kPriceDateFormat.format(timelinePaintData.dxToDateTime(position.dx)), style: kTextPriceStyle);
    final textPainter = TextPainter(text: textSpan, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    textPainter.layout(maxWidth: kStepX - 4);
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(position.dx, height + textPainter.height / 2 + kTextPricePadding),
        width: textPainter.width + 2 * kTextPricePadding,
        height: textPainter.height + 2 * kTextPricePadding,
      ),
      paint,
    );
    canvas.drawLine(
      Offset(position.dx, height),
      Offset(position.dx, height + kHatchWidth),
      axisPaint,
    );
    textPainter.paint(canvas, Offset(position.dx - textPainter.width / 2, height + kTextPricePadding));
  }
}
