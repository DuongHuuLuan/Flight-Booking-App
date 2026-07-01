import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/date_time_utils.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/widgets/airline_logo_circle.dart';
import 'package:flight_booking_app/core/widgets/app_card.dart';
import 'package:flight_booking_app/core/widgets/flight_route_row.dart';
import 'package:flight_booking_app/domain/entities/booking/booking_detail_entity.dart';
import 'package:flutter/material.dart';

class FlightInfoCard extends StatelessWidget {
  final BookingDetailFlightEntity flight;
  final double price;

  const FlightInfoCard({
    super.key,
    required this.flight,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  flight.airline.logoUrl.isNotEmpty
                      ? Image.network(
                          flight.airline.logoUrl,
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.height * 0.04,
                          errorBuilder: (_, _, _) => const AirlineLogoCircle(),
                        )
                      : const AirlineLogoCircle(),
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
                flight.flightNumber,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColor.greyDark,
                ),
              ),
            ],
          ).paddingAll(16),
          FlightRouteRow(
            departureTime: flight.departureTime.hhmm,
            departureCode: flight.departureAirport.code,
            departureLocation:
                "${flight.departureAirport.city}, ${flight.departureAirport.country}",
            arrivalTime: flight.arrivalTime.hhmm,
            arrivalCode: flight.arrivalAirport.code,
            arrivalLocation:
                "${flight.arrivalAirport.city}, ${flight.arrivalAirport.country}",
            centerWidget: Column(
              children: [
                Text(
                  flight.duration.durationText,
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: 4),
                const Icon(Icons.flight, color: AppColor.primary, size: 20),
                const SizedBox(height: 4),
              ],
            ),
          ).paddingHorizontal(16).paddingBottom(16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColor.grey50,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Price",
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColor.greyDark,
                  ),
                ),
                Text(
                  "\$${price.toStringAsFixed(0)}",
                  style: AppTextStyles.heading3.copyWith(
                    color: AppColor.primary,
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
