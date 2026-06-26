import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class AirlineLogoCircle extends StatelessWidget {
  final double size;
  final double iconSize;
  final Color? backgroundColor;
  final Color? iconColor;
  final IconData icon;

  const AirlineLogoCircle({
    super.key,
    this.size = 32,
    this.iconSize = 18,
    this.backgroundColor,
    this.iconColor,
    this.icon = Icons.flight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColor.primary,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: iconColor ?? AppColor.white,
        size: iconSize,
      ),
    );
  }
}
