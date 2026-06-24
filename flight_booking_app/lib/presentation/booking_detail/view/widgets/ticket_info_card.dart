import 'package:flight_booking_app/core/widgets/app_card.dart';
import 'package:flight_booking_app/domain/entities/booking_detail_entity.dart';
import 'package:flight_booking_app/presentation/booking_detail/view/widgets/ticket_item.dart';
import 'package:flutter/material.dart';

class TicketInfoCard extends StatelessWidget {
  final BookingDetailFlightEntity flight;
  final String? selectedSeats;
  final String cabinClass;

  const TicketInfoCard({
    super.key,
    required this.flight,
    required this.selectedSeats,
    required this.cabinClass,
  });

  @override
  Widget build(BuildContext context) {
    final classText = cabinClass.isNotEmpty
        ? "${cabinClass[0].toUpperCase()}${cabinClass.substring(1)}"
        : "—";

    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        children: [
          TicketItem(label: "Gate", value: "B5"),
          TicketItem(label: "Flight", value: flight.flightNumber),
          TicketItem(label: "Seat", value: selectedSeats ?? "—"),
          TicketItem(label: "Class", value: classText),
        ],
      ),
    );
  }
}
