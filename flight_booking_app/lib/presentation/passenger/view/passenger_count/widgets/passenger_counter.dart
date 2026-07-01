import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/presentation/passenger/view/passenger_count/widgets/counter_button.dart';
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
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.bodyLarge),
              const SizedBox(height: 2),
              Text(subtitle, style: AppTextStyles.caption),
            ],
          ),
        ),
        Row(
          children: [
            CounterButton(
              icon: Icons.remove,
              onPressed: value <= min ? null : onDecrement,
            ),
            SizedBox(
              width: 48,
              child: Text(
                '$value',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading3,
              ),
            ),
            CounterButton(icon: Icons.add, onPressed: onIncrement),
          ],
        ),
      ],
    );
  }
}
