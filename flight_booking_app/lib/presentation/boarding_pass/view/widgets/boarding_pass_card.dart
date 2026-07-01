import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/utils/date_time_utils.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/widgets/ticket_barcode.dart';
import 'package:flight_booking_app/domain/entities/booking/booking_detail_entity.dart';
import 'package:flight_booking_app/presentation/boarding_pass/view/widgets/airline_header.dart';
import 'package:flight_booking_app/presentation/boarding_pass/view/widgets/flight_route_section.dart';
import 'package:flight_booking_app/presentation/boarding_pass/view/widgets/info_grid.dart';
import 'package:flight_booking_app/presentation/boarding_pass/view/widgets/ticket_cutout_clipper.dart';
import 'package:flight_booking_app/presentation/boarding_pass/view/widgets/ticket_divider.dart';
import 'package:flutter/material.dart';

class BoardingPassCard extends StatelessWidget {
  final BookingDetailEntity booking;
  const BoardingPassCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final flight = booking.flight;
    final seatLabel = booking.selectedSeats?.split(',').first ?? '—';
    final ticketId = booking.id.length >= 6
        ? booking.id.substring(0, 6).toUpperCase()
        : booking.id.toUpperCase();

    return ClipPath(
      clipper: const TicketCutoutClipper(),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            AirlineHeader(
              airlineName: flight.airline.name,
            ).paddingOnly(left: 20, top: 20, right: 20, bottom: 0),

            const TicketDivider().paddingHorizontal(20),

            FlightRouteSection(
              departureTime: flight.departureTime.format12Hour,
              departureCode: flight.departureAirport.code,
              departureLocation:
                  '${flight.departureAirport.city}, ${flight.departureAirport.country}',
              arrivalTime: flight.arrivalTime.format12Hour,
              arrivalCode: flight.arrivalAirport.code,
              arrivalLocation:
                  '${flight.arrivalAirport.city}, ${flight.arrivalAirport.country}',
              duration: flight.duration.durationText,
            ).paddingHorizontal(20),

            TicketDivider().paddingHorizontal(20),

            InfoGrid(
              rows: [
                InfoRow(
                  'Gate',
                  'B5',
                  'Passenger',
                  '${booking.passengers.length} Adult',
                  'Flight',
                  flight.flightNumber,
                ),
                InfoRow(
                  'Seat',
                  seatLabel,
                  'Ticket ID',
                  ticketId,
                  '',
                  '',
                ),
                InfoRow(
                  'Date',
                  booking.createdAt.formatDate,
                  'Duration',
                  flight.duration.durationText,
                  'Baggage',
                  '20kg',
                ),
              ],
            ).paddingHorizontal(20),

            TicketDivider().paddingHorizontal(20),

            TicketBarcode(
              number: '5678098927365',
            ).paddingOnly(left: 20, top: 0, right: 20, bottom: 20),
          ],
        ),
      ),
    );
  }
}
