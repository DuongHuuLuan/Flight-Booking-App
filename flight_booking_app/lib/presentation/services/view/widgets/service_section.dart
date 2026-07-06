import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/domain/entities/seat/service_entity.dart';
import 'package:flight_booking_app/presentation/services/view/widgets/service_detail_sheet.dart';
import 'package:flight_booking_app/presentation/services/view/widgets/service_tile.dart';
import 'package:flutter/material.dart';

class ServiceSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<ServiceEntity> services;
  final Map<String, int> selections;
  final void Function(ServiceEntity service, int delta) onToggle;

  const ServiceSection({
    super.key,
    required this.title,
    required this.icon,
    required this.services,
    required this.selections,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: AppColor.primary),
            const SizedBox(width: 8),
            Text(title, style: AppTextStyles.heading3),
          ],
        ),
        const SizedBox(height: 12),
        for (final service in services)
          ServiceTile(
            service: service,
            count: selections[service.serviceId] ?? 0,
            onTap: () => ServiceDetailSheet.show(
              context,
              service: service,
              initialCount: selections[service.serviceId] ?? 0,
              onApply: (newCount) {
                final current = selections[service.serviceId] ?? 0;
                final delta = newCount - current;
                if (delta > 0) {
                  for (int i = 0; i < delta; i++) { onToggle(service, 1); }
                } else if (delta < 0) {
                  for (int i = 0; i < -delta; i++) { onToggle(service, -1); }
                }
              },
            ),
            onIncrement: () => onToggle(service, 1),
            onDecrement: () => onToggle(service, -1),
          ),
      ],
    );
  }
}
