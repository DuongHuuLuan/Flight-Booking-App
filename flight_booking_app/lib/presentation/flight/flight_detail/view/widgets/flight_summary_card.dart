import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/responsive.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/domain/entities/flight_detail_entity.dart';
import 'package:flutter/material.dart';

class FlightSummaryCard extends StatelessWidget {
  final FlightDetailEntity detail;
  const FlightSummaryCard({super.key, required this.detail});

  String _formatTime(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  String _durationText(int min) =>
      '${min ~/ 60}h ${(min % 60).toString().padLeft(2, '0')}m';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final dynamicPadding = Responsive.padding(screenWidth);
        final logoSize = Responsive.logoSize(screenWidth);
        final lineDurationWidth = Responsive.lineWidth(screenWidth);

        return Container(
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: logoSize,
                    height: logoSize,
                    decoration: const BoxDecoration(
                      color: AppColor.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.flight,
                      color: AppColor.white,
                      size: logoSize * 0.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      detail.airline.name,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    detail.flightNumber,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColor.greyDark,
                    ),
                  ),
                ],
              ).paddingAll(dynamicPadding),

              const Divider(height: 1, color: AppColor.greyLight),

              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _formatTime(detail.departureTime),
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          detail.departureAirport.code,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColor.greyDark,
                          ),
                        ),
                        Text(
                          detail.departureAirport.city,
                          style: AppTextStyles.caption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _durationText(detail.duration),
                          style: AppTextStyles.caption,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: lineDurationWidth,
                          height: 1,
                          color: AppColor.greyLight,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          detail.stops == 0
                              ? "Non Stop"
                              : "${detail.stops} Stop",
                          style: AppTextStyles.caption.copyWith(
                            color: AppColor.greyDark,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _formatTime(detail.arrivalTime),
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          detail.arrivalAirport.code,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColor.greyDark,
                          ),
                        ),
                        Text(
                          detail.arrivalAirport.city,
                          style: AppTextStyles.caption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ).paddingAll(dynamicPadding),

              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "View Details",
                      style: AppTextStyles.caption.copyWith(
                        color: AppColor.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 10,
                      color: AppColor.primary,
                    ),
                  ],
                ),
              ).paddingOnly(bottom: dynamicPadding),
            ],
          ),
        );
      },
    );
  }
}
