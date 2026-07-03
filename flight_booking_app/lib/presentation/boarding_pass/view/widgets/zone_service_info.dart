import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/domain/entities/booking/booking_detail_entity.dart';
import 'package:flutter/material.dart';

class ZoneServiceInfo extends StatelessWidget {
  final BookingDetailEntity booking;

  const ZoneServiceInfo({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final services = booking.services ?? [];
    final zonePrice = booking.zonePriceTotal;
    final hasExtra = zonePrice != null && zonePrice > 0;
    final hasServices = services.isNotEmpty;

    if (!hasExtra && !hasServices) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additional Info',
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          if (hasExtra)
            _InfoTile(
              icon: Icons.event_seat,
              label: 'Zone Surcharge',
              value: '\$${(zonePrice).toStringAsFixed(0)}',
            ),
          if (hasServices) ...[
            const SizedBox(height: 8),
            Text(
              'Booked Services',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColor.greyDark,
              ),
            ),
            const SizedBox(height: 8),
            for (final s in services)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Icon(
                      _serviceIcon(s.serviceType),
                      size: 16,
                      color: AppColor.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${s.serviceName} (x${s.quantity})',
                        style: AppTextStyles.bodySmall,
                      ),
                    ),
                    Text(
                      '\$${(s.totalPrice).toStringAsFixed(0)}',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
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

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColor.primary),
        const SizedBox(width: 8),
        Expanded(child: Text(label, style: AppTextStyles.bodySmall)),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
