import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppBottomSheet {
  static void show(
    BuildContext context, {
    required WidgetBuilder builder,
    bool isScrollControlled = false,
  }) {
    showModalBottomSheet(
      backgroundColor: AppColor.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: isScrollControlled,
      builder: builder,
    );
  }
}
