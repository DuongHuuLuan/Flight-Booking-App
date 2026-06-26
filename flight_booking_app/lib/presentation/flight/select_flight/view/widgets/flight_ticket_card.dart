import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/date_time_utils.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/widgets/airline_logo_circle.dart';
import 'package:flight_booking_app/core/widgets/app_card.dart';
import 'package:flight_booking_app/core/widgets/flight_route_row.dart';
import 'package:flight_booking_app/domain/entities/flight.dart';
import 'package:flutter/material.dart';

class FlightTicketCard extends StatelessWidget {
  final FlightEntity flight;
  final VoidCallback? onTap;
  const FlightTicketCard({super.key, required this.flight, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const AirlineLogoCircle(),
                  const SizedBox(width: 8),
                  Text(
                    flight.airline.name,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Text(
                "\$${flight.price.toStringAsFixed(0)}",
                style: AppTextStyles.heading3.copyWith(
                  color: AppColor.primary,
                ),
              ),
            ],
          ).paddingAll(10),
          FlightRouteRow(
            departureTime: flight.departureTime.hhmm,
            departureCode: flight.departureAirport.code,
            departureLocation: flight.departureAirport.city,
            arrivalTime: flight.arrivalTime.hhmm,
            arrivalCode: flight.arrivalAirport.code,
            arrivalLocation: flight.arrivalAirport.city,
            centerWidget: Column(
              children: [
                Text(
                  flight.duration.durationText,
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: 4),
                Container(width: 80, height: 1, color: AppColor.greyLight),
                const SizedBox(height: 4),
                Text(
                  flight.stops == 0
                      ? "Non Stop"
                      : "${flight.stops} Stop${flight.stops > 1 ? 's' : ''}",
                  style: AppTextStyles.caption.copyWith(
                    color: AppColor.greyDark,
                  ),
                ),
              ],
            ),
          ).paddingAll(16),
        ],
      ),
    );
  }
}
