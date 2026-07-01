import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/domain/entities/seat/service_entity.dart';
import 'package:flutter/material.dart';

class ServiceTile extends StatelessWidget {
  final ServiceEntity service;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ServiceTile({
    super.key,
    required this.service,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: AppColor.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
              _IconButton(
                icon: Icons.remove,
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
              _IconButton(
                icon: Icons.add,
                onPressed: count >= service.maxPerPassenger
                    ? null
                    : onIncrement,
              ),
            ],
          ),
        ],
      ).paddingVertical(8).paddingHorizontal(12),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _IconButton({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: onPressed != null
          ? AppColor.primary.withValues(alpha: 0.1)
          : AppColor.border,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(
            icon,
            size: 18,
            color: onPressed != null ? AppColor.primary : AppColor.greyDark,
          ),
        ),
      ),
    );
  }
}
