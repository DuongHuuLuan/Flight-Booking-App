import 'package:flight_booking_app/core/widgets/app_card.dart';
import 'package:flight_booking_app/domain/entities/booking/booking_detail_entity.dart';
import 'package:flight_booking_app/presentation/booking_detail/view/widgets/ticket_item.dart';
import 'package:flutter/material.dart';

class TicketInfoCard extends StatelessWidget {
  final BookingDetailFlightEntity flight;
  final String? selectedSeats;

  const TicketInfoCard({
    super.key,
    required this.flight,
    required this.selectedSeats,
  });

  @override
  Widget build(BuildContext context) {

    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        children: [
          TicketItem(label: "Gate", value: "B5"),
          TicketItem(label: "Flight", value: flight.flightNumber),
          TicketItem(label: "Seat", value: selectedSeats ?? "—"),
        ],
      ),
    );
  }
}
