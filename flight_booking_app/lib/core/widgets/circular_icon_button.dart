import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final double padding;
  final VoidCallback? onPressed;

  const CircularIconButton({
    super.key,
    required this.icon,
    this.iconSize = 20,
    this.padding = 8,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return Material(
      color: enabled
          ? AppColor.primary.withValues(alpha: 0.1)
          : AppColor.border,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Icon(
            icon,
            size: iconSize,
            color: enabled ? AppColor.primary : AppColor.greyDark,
          ),
        ),
      ),
    );
  }
}
