import 'dart:math' as math;

import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/domain/entities/flight_detail_entity.dart';
import 'package:flight_booking_app/domain/enums/cabin_class.dart';
import 'package:flutter/material.dart';

class CabinClassSelector extends StatelessWidget {
  final List<CabinClassOption> cabinClasses;
  final CabinClassOption? selected;
  final void Function(CabinClassOption) onSelected;

  const CabinClassSelector({
    super.key,
    required this.cabinClasses,
    required this.selected,
    required this.onSelected,
  });

  String _label(CabinClass c) {
    switch (c) {
      case CabinClass.economy:
        return "Economy";
      case CabinClass.business:
        return "Business";
      case CabinClass.first:
        return "First Class";
    }
  }

  IconData _icon(CabinClass c) {
    switch (c) {
      case CabinClass.economy:
        return Icons.event_seat;
      case CabinClass.business:
        return Icons.airline_seat_flat;
      case CabinClass.first:
        return Icons.star;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        final cardWidth = math.min(screenWidth * 0.68, 280.0);
        final cardHeight = cardWidth * 0.9;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Your Class", style: AppTextStyles.heading3),
              const SizedBox(height: 12),

              SizedBox(
                height: cardHeight,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: cabinClasses.length,
                  separatorBuilder: (_, _) =>
                      SizedBox(width: screenWidth * 0.03),
                  itemBuilder: (_, i) {
                    final c = cabinClasses[i];
                    final isSelected = selected?.cabinClass == c.cabinClass;

                    return GestureDetector(
                      onTap: () => onSelected(c),
                      child: Container(
                        width: cardWidth,
                        padding: EdgeInsets.all(cardWidth * 0.08),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? AppColor.primary
                                : AppColor.greyLight,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  _icon(c.cabinClass),
                                  color: AppColor.primary,
                                  size: cardWidth * 0.1,
                                ),
                                const Spacer(),
                                Radio<CabinClass>(
                                  value: c.cabinClass,
                                  groupValue: selected?.cabinClass,
                                  activeColor: AppColor.primary,
                                  onChanged: (_) => onSelected(c),
                                ),
                              ],
                            ),

                            SizedBox(height: cardHeight * 0.02),

                            Text(
                              _label(c.cabinClass),
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(height: cardHeight * 0.02),

                            Text(
                              "\$${c.price.toStringAsFixed(0)}",
                              style: AppTextStyles.heading3.copyWith(
                                color: AppColor.primary,
                              ),
                            ),

                            SizedBox(height: cardHeight * 0.04),

                            Expanded(
                              child: ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                children: c.amenities.take(3).map((a) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom: cardHeight * 0.015,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.check,
                                          size: cardWidth * 0.06,
                                          color: AppColor.greyDark,
                                        ),
                                        SizedBox(width: cardWidth * 0.025),
                                        Expanded(
                                          child: Text(
                                            a,
                                            style: AppTextStyles.caption
                                                .copyWith(
                                                  color: AppColor.greyDark,
                                                ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
