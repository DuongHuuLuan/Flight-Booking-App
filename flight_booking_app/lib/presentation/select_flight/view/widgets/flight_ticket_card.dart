import 'package:flutter/material.dart';
import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/domain/entities/flight.dart';

class FlightTicketCard extends StatelessWidget {
  final FlightEntity flight;
  final VoidCallback? onTap;
  const FlightTicketCard({super.key, required this.flight, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: AppColor.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.flight,
                        color: AppColor.white,
                        size: 18,
                      ),
                    ),
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
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatTime(flight.departureTime),
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        flight.departureAirport.code,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColor.greyDark,
                        ),
                      ),
                      Text(
                        flight.departureAirport.city,
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "${flight.duration ~/ 60}h ${flight.duration % 60}m",
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _formatTime(flight.arrivalTime),
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        flight.arrivalAirport.code,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColor.greyDark,
                        ),
                      ),
                      Text(
                        flight.arrivalAirport.city,
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }
}
