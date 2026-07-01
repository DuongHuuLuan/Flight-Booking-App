import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/widgets/label_value_row.dart';
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
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
        ).paddingHorizontal(16).paddingTop(16),
        const SizedBox(height: 12),
        LabelValueRow(
          label: "Full Name",
          value: passenger.name,
          showDivider: true,
        ),
        LabelValueRow(
          label: "Full Name",
          value: passenger.name,
          showDivider: true,
        ),
        LabelValueRow(
          label: "Full Name",
          value: passenger.name,
          showDivider: true,
        ),
        if (showDivider)
          const Divider(
            height: 32,
            color: AppColor.greyLight,
          ).paddingHorizontal(16),
      ],
    );
  }
}
