import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/date_time_utils.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/domain/entities/flight.dart';
import 'package:flutter/material.dart';

class PopularFlightCard extends StatelessWidget {
  final FlightEntity flight;
  final VoidCallback? onTap;
  const PopularFlightCard({super.key, required this.flight, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: AppColor.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  flight.airline.name,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  flight.flightNumber,
                  style: AppTextStyles.bodySmall.copyWith(color: AppColor.grey),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        flight.departureTime.hhmm,
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.grey,
                        ),
                      ),
                      Text(
                        flight.departureAirport.code,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColor.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        flight.departureAirport.city,
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.38,
                      child: Divider(color: AppColor.greyLight, thickness: 1),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.primary.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColor.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Icon(
                              Icons.flight,
                              size: 14,
                              color: AppColor.primary,
                            ),
                          ).paddingAll(2),
                        ).paddingAll(6),
                      ).paddingAll(4),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        flight.arrivalTime.hhmm,
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.grey,
                        ),
                      ),
                      Text(
                        flight.arrivalAirport.code,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColor.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        flight.arrivalAirport.city,
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ).paddingAll(20),
      ),
    );
  }
}
