import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class FlightHeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final mapPaint = Paint()
      ..color = AppColor.white.withValues(alpha: 0.07)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 0; i < 28; i++) {
      final x = (i * 17) % size.width;
      final y = 20 + ((i * 29) % 95);

      canvas.drawCircle(Offset(x.toDouble(), y.toDouble()), 1.2, mapPaint);
    }

    final path = Path()
      ..moveTo(46, size.height - 64)
      ..quadraticBezierTo(
        size.width / 2,
        size.height - 118,
        size.width - 46,
        size.height - 64,
      );

    final dashPaint = Paint()
      ..color = AppColor.white.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    _drawDashedPath(canvas, path, dashPaint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    const dashWidth = 5.0;
    const dashSpace = 5.0;

    for (final metric in path.computeMetrics()) {
      double distance = 0;

      while (distance < metric.length) {
        final next = distance + dashWidth;
        final extractPath = metric.extractPath(distance, next);
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
