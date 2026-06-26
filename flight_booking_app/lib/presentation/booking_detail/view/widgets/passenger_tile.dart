import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/date_time_utils.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/domain/entities/passenger_entity.dart';
import 'package:flutter/material.dart';

class PassengerTile extends StatelessWidget {
  final PassengerEntity passenger;
  final int index;
  final bool showDivider;

  const PassengerTile({
    super.key,
    required this.passenger,
    required this.index,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Passenger $index",
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ).paddingHorizontal(16).paddingTop(16),
        const SizedBox(height: 12),
        _infoRow("Full Name", passenger.name),
        const Divider(height: 1, color: AppColor.grey100),
        _infoRow("Passport ID", passenger.passportNumber),
        const Divider(height: 1, color: AppColor.grey100),
        _infoRow("Date of Birth", passenger.dateOfBirth.formatDate),
        if (showDivider)
          const Divider(height: 32, color: AppColor.greyLight).paddingHorizontal(
            16,
          ),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColor.greyDark,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ).paddingHorizontal(16).paddingVertical(12);
  }
}
