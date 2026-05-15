import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension HomeNavigation on BuildContext {
  void goToHome() => go('/home');
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _FlightBookingState();
}

class _FlightBookingState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("HOME")));
  }
}
