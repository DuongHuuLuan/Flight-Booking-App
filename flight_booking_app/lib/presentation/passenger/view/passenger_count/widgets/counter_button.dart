import 'package:flight_booking_app/core/widgets/circular_icon_button.dart';
import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const CounterButton({super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CircularIconButton(
      icon: icon,
      iconSize: 20,
      padding: 8,
      onPressed: onPressed,
    );
  }
}
