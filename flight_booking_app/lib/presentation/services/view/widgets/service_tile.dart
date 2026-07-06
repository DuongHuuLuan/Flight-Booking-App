import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/widgets/circular_icon_button.dart';
import 'package:flight_booking_app/domain/entities/seat/service_entity.dart';
import 'package:flutter/material.dart';

class ServiceTile extends StatelessWidget {
  final ServiceEntity service;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onTap;

  const ServiceTile({
    super.key,
    required this.service,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: AppColor.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service.name, style: AppTextStyles.bodyLarge),
                  Text(
                    '\$${service.price.toStringAsFixed(0)}',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                CircularIconButton(
                  icon: Icons.remove,
                  iconSize: 18,
                  padding: 6,
                  onPressed: count <= 0 ? null : onDecrement,
                ),
                SizedBox(
                  width: 32,
                  child: Text(
                    '$count',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyLarge,
                  ),
                ),
                CircularIconButton(
                  icon: Icons.add,
                  iconSize: 18,
                  padding: 6,
                  onPressed: count >= service.maxPerPassenger
                      ? null
                      : onIncrement,
                ),
              ],
            ),
          ],
        ).paddingVertical(8).paddingHorizontal(12),
      ),
    );
  }
}
