import 'package:flutter/material.dart';

class TicketCutoutClipper extends CustomClipper<Path> {
  final double radius;
  final double borderRadius;

  const TicketCutoutClipper({this.radius = 12, this.borderRadius = 16});

  @override
  Path getClip(Size size) {
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          Radius.circular(borderRadius),
        ),
      );

    final cutouts = Path()
      // left
      ..addOval(
        Rect.fromCircle(center: Offset(0, size.height * 0.45), radius: radius),
      )
      ..addOval(
        Rect.fromCircle(center: Offset(0, size.height * 0.55), radius: radius),
      )
      // right
      ..addOval(
        Rect.fromCircle(
          center: Offset(size.width, size.height * 0.45),
          radius: radius,
        ),
      )
      ..addOval(
        Rect.fromCircle(
          center: Offset(size.width, size.height * 0.55),
          radius: radius,
        ),
      );

    return Path.combine(PathOperation.difference, path, cutouts);
  }

  @override
  bool shouldReclip(covariant TicketCutoutClipper oldClipper) {
    return oldClipper.radius != radius ||
        oldClipper.borderRadius != borderRadius;
  }
}
