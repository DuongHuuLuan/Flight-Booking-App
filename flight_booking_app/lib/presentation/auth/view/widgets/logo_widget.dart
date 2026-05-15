import 'package:flutter/widgets.dart';

class LogoWidget extends StatelessWidget {
  final String imagePath;
  const LogoWidget({super.key, required this.imagePath});
  @override
  Widget build(BuildContext context) {
    return Image.asset(imagePath, fit: BoxFit.contain);
  }
}
