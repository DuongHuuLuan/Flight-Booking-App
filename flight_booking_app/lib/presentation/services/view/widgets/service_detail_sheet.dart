import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/widgets/app_bottom_sheet.dart';
import 'package:flight_booking_app/core/widgets/quantity_selector.dart';
import 'package:flight_booking_app/domain/entities/seat/service_entity.dart';
import 'package:flutter/material.dart';

class ServiceDetailSheet extends StatefulWidget {
  final ServiceEntity service;
  final int initialCount;
  final ValueChanged<int> onApply;

  const ServiceDetailSheet({
    super.key,
    required this.service,
    required this.initialCount,
    required this.onApply,
  });

  static void show(
    BuildContext context, {
    required ServiceEntity service,
    required int initialCount,
    required ValueChanged<int> onApply,
  }) {
    AppBottomSheet.show(
      context,
      builder: (_) => ServiceDetailSheet(
        service: service,
        initialCount: initialCount,
        onApply: onApply,
      ),
    );
  }

  @override
  State<ServiceDetailSheet> createState() => _ServiceDetailSheetState();
}

class _ServiceDetailSheetState extends State<ServiceDetailSheet> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.initialCount;
  }

  IconData get _icon => switch (widget.service.type) {
    'meal' => Icons.restaurant,
    'drink' => Icons.local_drink,
    'baggage' => Icons.luggage,
    _ => Icons.sell,
  };

  @override
  Widget build(BuildContext context) {
    final service = widget.service;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColor.grey200,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColor.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(_icon, size: 28, color: AppColor.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(service.name, style: AppTextStyles.heading3),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '\$${service.price.toStringAsFixed(0)}',
          style: AppTextStyles.heading2.copyWith(color: AppColor.primary),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColor.background,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            service.description ?? 'No description available',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColor.greyDark,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: QuantitySelector(
            value: _count,
            min: 0,
            max: service.maxPerPassenger,
            countWidth: 48,
            countStyle: AppTextStyles.heading3,
            onIncrement: () => setState(() => _count++),
            onDecrement: () => setState(() => _count--),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              widget.onApply(_count);
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary,
              foregroundColor: AppColor.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Apply'),
          ),
        ),
      ],
    ).paddingOnly(left: 24, top: 16, right: 24, bottom: 32);
  }
}
