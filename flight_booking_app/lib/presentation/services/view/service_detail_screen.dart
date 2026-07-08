import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/widgets/quantity_selector.dart';
import 'package:flight_booking_app/domain/entities/seat/service_entity.dart';
import 'package:flutter/material.dart';

class ServiceDetailScreen extends StatefulWidget {
  static String get routerName => '/service-detail';

  final ServiceEntity service;
  final int initialCount;

  const ServiceDetailScreen({
    super.key,
    required this.service,
    required this.initialCount,
  });

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
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
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text(service.name, style: AppTextStyles.heading3),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColor.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(_icon, size: 32, color: AppColor.primary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(service.name, style: AppTextStyles.heading3),
                        const SizedBox(height: 4),
                        Text(
                          '\$${service.price.toStringAsFixed(0)}',
                          style: AppTextStyles.heading2.copyWith(
                            color: AppColor.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
            ],
          ).paddingHorizontal(24),
          const Spacer(),
          Center(
            child: QuantitySelector(
              value: _count,
              min: 0,
              max: service.maxPerPassenger,
              countWidth: 64,
              countStyle: AppTextStyles.heading1,
              onIncrement: () => setState(() => _count++),
              onDecrement: () => setState(() => _count--),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(_count),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                foregroundColor: AppColor.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Apply', style: AppTextStyles.button),
            ),
          ).paddingOnly(left: 14, top: 0, right: 24, bottom: 32),
        ],
      ),
    );
  }
}
