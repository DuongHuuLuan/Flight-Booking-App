import 'package:flight_booking_app/ui/core/theme/app_color.dart';
import 'package:flight_booking_app/ui/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColor.primary,
        error: AppColor.error,
      ),

      textTheme: const TextTheme(
        displayLarge: AppTextStyles.heading1,
        bodyMedium: AppTextStyles.body,
      ),
    );
  }
}
