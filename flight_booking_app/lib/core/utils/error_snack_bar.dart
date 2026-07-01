import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

extension ErrorSnackBar on BuildContext {
  void showError(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColor.error),
    );
  }
}
