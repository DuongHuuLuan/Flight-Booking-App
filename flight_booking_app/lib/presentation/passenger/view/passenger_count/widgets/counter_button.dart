import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const CounterButton({super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: onPressed != null
          ? AppColor.primary.withValues(alpha: 0.1)
          : AppColor.border,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Icon(
          icon,
          size: 20,
          color: onPressed != null ? AppColor.primary : AppColor.greyDark,
        ).paddingAll(8),
      ),
    );
  }
}
