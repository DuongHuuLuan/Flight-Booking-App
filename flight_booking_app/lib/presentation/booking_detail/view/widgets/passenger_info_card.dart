import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/widgets/app_card.dart';
import 'package:flight_booking_app/domain/entities/passenger_entity.dart';
import 'package:flight_booking_app/presentation/booking_detail/view/widgets/passenger_tile.dart';
import 'package:flutter/material.dart';

class PassengerInfoCard extends StatelessWidget {
  final List<PassengerEntity> passengers;

  const PassengerInfoCard({super.key, required this.passengers});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Passengers", style: AppTextStyles.heading3).paddingAll(16),
          const Divider(height: 1, color: AppColor.grey100),
          ...List.generate(
            passengers.length,
            (index) => PassengerTile(
              passenger: passengers[index],
              index: index + 1,
              showDivider: index != passengers.length - 1,
            ),
          ),
        ],
      ),
    );
  }
}
