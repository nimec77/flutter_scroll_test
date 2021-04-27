import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_scroll_test/presentation/widgets/constants.dart';

class PriceWidget extends StatefulWidget {
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
    return GestureDetector(
      onPanStart: (details) {
        // debugPrint('global:${details.globalPosition}, local:${details.localPosition}');
        setState(() {
          position = details.localPosition;
        });
      },
      onPanUpdate: (details) {
        // debugPrint('global:${details.globalPosition}, local:${details.localPosition}');
        setState(() {
          position = details.localPosition;
        });
      },
      child: CustomPaint(
        painter: _PriceWidgetPainter(position),
      ),
    );
  }
}

class _PriceWidgetPainter extends CustomPainter {
  final Offset position;

  _PriceWidgetPainter(this.position);

  @override
  void paint(Canvas canvas, Size size) {
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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
