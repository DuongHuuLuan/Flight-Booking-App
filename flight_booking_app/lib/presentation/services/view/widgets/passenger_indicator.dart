import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class PassengerIndicator extends StatelessWidget {
  final int current;
  final int total;
  final String name;
  final String seatLabel;

  const PassengerIndicator({
    super.key,
    required this.current,
    required this.total,
    required this.name,
    required this.seatLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColor.background,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '$current / $total',
              style: AppTextStyles.caption.copyWith(color: AppColor.white),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.isEmpty ? 'Passenger $current' : name,
                  style: AppTextStyles.bodyLarge,
                ),
                if (seatLabel.isNotEmpty)
                  Text(
                    'Seat $seatLabel',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColor.greyDark,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
