import 'package:flutter/material.dart';

class OnboardingImage extends StatelessWidget {
  final String? imageUrl;

  const OnboardingImage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: imageUrl != null
          ? Image.asset(imageUrl!, fit: BoxFit.contain)
          : Center(child: Text("No Image Available")),
    );
  }
}
