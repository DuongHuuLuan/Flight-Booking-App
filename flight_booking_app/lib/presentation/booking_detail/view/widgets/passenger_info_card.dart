import 'package:flight_booking_app/core/widgets/section_card.dart';
import 'package:flight_booking_app/domain/entities/passenger_entity.dart';
import 'package:flight_booking_app/presentation/booking_detail/view/widgets/passenger_tile.dart';
import 'package:flutter/material.dart';

class PassengerInfoCard extends StatelessWidget {
  final List<PassengerEntity> passengers;

  const PassengerInfoCard({super.key, required this.passengers});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: "Passengers",
      children: List.generate(
        passengers.length,
        (index) => PassengerTile(
          passenger: passengers[index],
          index: index + 1,
          showDivider: index != passengers.length - 1,
        ),
      ),
    );
  }
}
