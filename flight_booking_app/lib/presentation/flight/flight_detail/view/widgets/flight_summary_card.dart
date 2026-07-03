import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/date_time_utils.dart';
import 'package:flight_booking_app/core/utils/responsive.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/widgets/airline_logo_circle.dart';
import 'package:flight_booking_app/core/widgets/app_card.dart';
import 'package:flight_booking_app/core/widgets/flight_route_row.dart';
import 'package:flight_booking_app/domain/entities/flight_detail_entity.dart';
import 'package:flutter/material.dart';

class FlightSummaryCard extends StatelessWidget {
  final FlightDetailEntity detail;
  const FlightSummaryCard({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final dynamicPadding = Responsive.padding(screenWidth);
        final logoSize = Responsive.logoSize(screenWidth);
        final lineDurationWidth = Responsive.lineWidth(screenWidth);

        return AppCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  AirlineLogoCircle(
                    size: logoSize,
                    iconSize: logoSize * 0.5,
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
              FlightRouteRow(
                departureTime: detail.departureTime.hhmm,
                departureCode: detail.departureAirport.code,
                departureLocation: detail.departureAirport.city,
                arrivalTime: detail.arrivalTime.hhmm,
                arrivalCode: detail.arrivalAirport.code,
                arrivalLocation: detail.arrivalAirport.city,
                centerWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      detail.duration.durationText,
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
                      detail.stopsDisplay,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColor.greyDark,
                      ),
                    ),
                  ],
                ),
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
