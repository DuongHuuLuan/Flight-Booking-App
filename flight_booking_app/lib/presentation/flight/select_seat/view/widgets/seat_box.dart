import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class SeatBox extends StatelessWidget {
  final String? label;
  final bool isSelected;
  final bool isReserved;
  final bool canSelect;
  final Color? zoneColor;
  final VoidCallback? onTap;

  const SeatBox({
    super.key,
    this.label,
    this.isSelected = false,
    this.isReserved = false,
    this.canSelect = true,
    this.zoneColor,
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
    final bool disabled = !canSelect && !isSelected;

    Color bgColor;
    if (isSelected) {
      bgColor = AppColor.primary;
    } else if (disabled) {
      bgColor = AppColor.grey200;
    } else if (zoneColor != null) {
      bgColor = zoneColor!.withValues(alpha: 0.2);
    } else {
      bgColor = AppColor.white;
    }

    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.13,
        height: MediaQuery.of(context).size.height * 0.05,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: isSelected || (zoneColor != null && !disabled)
              ? Border.all(
                  color: (zoneColor ?? AppColor.grey300).withValues(alpha: 0.5),
                )
              : Border.all(color: AppColor.grey300),
        ),
        child: Text(
          label ?? "",
          style: AppTextStyles.caption.copyWith(
            color: isSelected
                ? AppColor.white
                : disabled
                ? AppColor.grey400
                : AppColor.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
