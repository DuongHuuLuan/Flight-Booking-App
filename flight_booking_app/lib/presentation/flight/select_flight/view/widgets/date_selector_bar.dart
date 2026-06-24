import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class DateSelectorBar extends StatelessWidget {
  final DateTime selectedDate;
  final void Function(DateTime) onDateSelected;
  const DateSelectorBar({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });
  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final days = List.generate(14, (i) => today.add(Duration(days: i)));
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: days.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final date = days[index];
          final isSelected =
              date.year == selectedDate.year &&
              date.month == selectedDate.month &&
              date.day == selectedDate.day;
          final dayNames = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
          final dayName = dayNames[date.weekday - 1];
          final monthNames = [
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
          ];
          final monthName = monthNames[date.month - 1];
          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: Container(
              width: 68,
              decoration: BoxDecoration(
                color: isSelected ? AppColor.primary : AppColor.greyLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dayName,
                    style: AppTextStyles.caption.copyWith(
                      color: isSelected ? AppColor.white : AppColor.greyDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${date.day}",
                    style: AppTextStyles.heading3.copyWith(
                      color: isSelected ? AppColor.white : AppColor.black87,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    monthName,
                    style: AppTextStyles.caption.copyWith(
                      color: isSelected ? AppColor.white : AppColor.greyDark,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
