import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/widgets/circular_icon_button.dart';
import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int value;
  final int min;
  final int max;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final String? label;
  final String? subtitle;
  final TextStyle? countStyle;
  final double countWidth;

  const QuantitySelector({
    super.key,
    required this.value,
    required this.min,
    this.max = 99,
    required this.onIncrement,
    required this.onDecrement,
    this.label,
    this.subtitle,
    this.countStyle,
    this.countWidth = 48,
  });

  @override
  Widget build(BuildContext context) {
    final countWidget = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularIconButton(
          icon: Icons.remove,
          iconSize: 18,
          padding: 6,
          onPressed: value > min ? onDecrement : null,
        ),
        SizedBox(
          width: countWidth,
          child: Text(
            '$value',
            textAlign: TextAlign.center,
            style: countStyle ?? AppTextStyles.bodyLarge,
          ),
        ),
        CircularIconButton(
          icon: Icons.add,
          iconSize: 18,
          padding: 6,
          onPressed: value < max ? onIncrement : null,
        ),
      ],
    );

    if (label == null && subtitle == null) return countWidget;

    return Row(
      children: [
        if (label != null)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label!, style: AppTextStyles.bodyLarge),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(subtitle!, style: AppTextStyles.caption),
                ],
              ],
            ),
          ),
        countWidget,
      ],
    );
  }
}
