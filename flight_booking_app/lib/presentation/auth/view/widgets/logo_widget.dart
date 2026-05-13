import 'package:flutter/widgets.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/logo.png",
      width: 150,
      height: 150,
      fit: BoxFit.contain,
    );
  }
}
