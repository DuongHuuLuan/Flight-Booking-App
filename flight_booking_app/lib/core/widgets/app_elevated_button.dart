import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final double? borderRadius;
  const AppElevatedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.height,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.borderRadius,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColor.primary,
          foregroundColor: foregroundColor ?? AppColor.primary,
          disabledBackgroundColor:
              disabledBackgroundColor ?? AppColor.greyLight,
          disabledForegroundColor:
              disabledForegroundColor ?? AppColor.greyLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: foregroundColor ?? AppColor.white,
                ),
              )
            : Text(label),
      ),
    );
  }
}
