import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/widgets/section_card.dart';
import 'package:flight_booking_app/domain/entities/booking/booking_detail_entity.dart';
import 'package:flutter/material.dart';

class ServiceListCard extends StatelessWidget {
  final List<BookingServiceEntity> services;

  const ServiceListCard({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: "Services",
      children: [
        for (final s in services)
          Row(
            children: [
              Icon(
                _serviceIcon(s.serviceType),
                size: 18,
                color: AppColor.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.serviceName, style: AppTextStyles.bodyMedium),
                    Text(
                      'Seat ${s.seatLabel}',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColor.greyDark,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '\$${(s.totalPrice).toStringAsFixed(0)}',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ).paddingVertical(8).paddingHorizontal(16),
      ],
    );
  }

  IconData _serviceIcon(String type) {
    return switch (type) {
      'meal' => Icons.restaurant,
      'drink' => Icons.local_drink,
      'baggage' => Icons.luggage,
      _ => Icons.sell,
    };
  }
}
