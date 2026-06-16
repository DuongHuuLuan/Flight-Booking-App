import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(20),
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
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColor.grey),
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
                          _formatTime(flight.departureTime),
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
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColor.primary.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppColor.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: Icon(
                                Icons.flight,
                                size: 14,
                                color: AppColor.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _formatTime(flight.arrivalTime),
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
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }
}
