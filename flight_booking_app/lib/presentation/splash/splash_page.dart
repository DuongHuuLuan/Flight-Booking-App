import 'package:flight_booking_app/core/utils/navigation_exp.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static String get routerName => '/';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboarding();
  }

  void _navigateToOnboarding() async {
    await Future.delayed(
      const Duration(seconds: 2),
    ); // giữ màn hình splash trong 2 giây
    if (mounted) {
      context.goToOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/splash.jpg',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
