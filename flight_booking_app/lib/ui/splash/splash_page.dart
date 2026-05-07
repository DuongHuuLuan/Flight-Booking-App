import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
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
      context.go("/onboarding");
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
