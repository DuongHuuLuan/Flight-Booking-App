import 'package:flight_booking_app/core/widgets/quantity_selector.dart';
import 'package:flutter/material.dart';

class PassengerCounter extends StatelessWidget {
  final String label;
  final String subtitle;
  final int value;
  final int min;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const PassengerCounter({
    super.key,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.min,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return QuantitySelector(
      value: value,
      min: min,
      label: label,
      subtitle: subtitle,
      onIncrement: onIncrement,
      onDecrement: onDecrement,
    );
  }
}
