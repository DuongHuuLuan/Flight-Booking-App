import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppBackgroundImage extends StatelessWidget {
  final String? imageUrl;

  const AppBackgroundImage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      child: imageUrl != null
          ? Image.asset(imageUrl!, fit: BoxFit.contain)
          : Center(child: Text("No Image Available")),
    );
  }
}
