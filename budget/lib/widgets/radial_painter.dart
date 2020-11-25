import 'dart:math';

import 'package:flutter/cupertino.dart';

class RadialPainter extends CustomPainter {
  final Color bgColor;
  final Color lineColor;
  final double width;
  double percent;

  RadialPainter({this.bgColor, this.lineColor, this.width, this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    Paint bgLine = Paint();
    bgLine.color = bgColor;
    bgLine.strokeCap = StrokeCap.round;
    bgLine.style = PaintingStyle.stroke;
    bgLine.strokeWidth = width;

    Paint completeLine = Paint();
    completeLine.color = lineColor;
    completeLine.strokeCap = StrokeCap.round;
    completeLine.style = PaintingStyle.stroke;
    completeLine.strokeWidth = width;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, bgLine);

    double sweepAngle = 2 * pi * percent;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2, sweepAngle, false, completeLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}