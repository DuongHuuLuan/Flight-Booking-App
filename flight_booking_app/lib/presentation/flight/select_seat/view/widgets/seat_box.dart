import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class SeatBox extends StatelessWidget {
  final String? label;
  final bool isSelected;
  final bool isReserved;
  final VoidCallback? onTap;

  const SeatBox({
    super.key,
    this.label,
    this.isSelected = false,
    this.isReserved = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isReserved) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.13,
        height: MediaQuery.of(context).size.height * 0.05,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: AppColor.grey200,
          borderRadius: BorderRadius.circular(8),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.13,
        height: MediaQuery.of(context).size.height * 0.05,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primary : AppColor.white,
          borderRadius: BorderRadius.circular(8),
          border: isSelected ? null : Border.all(color: AppColor.grey300),
        ),
        child: Text(
          label ?? "",
          style: AppTextStyles.caption.copyWith(
            color: isSelected ? AppColor.white : AppColor.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
