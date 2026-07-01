import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class PriceRow extends StatelessWidget {
  final String label;
  final String amount;
  final bool isTotal;
  final TextStyle? labelStyle;
  final TextStyle? amountStyle;

  const PriceRow({
    super.key,
    required this.label,
    required this.amount,
    this.isTotal = false,
    this.labelStyle,
    this.amountStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: labelStyle ??
                (isTotal
                    ? AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    )
                    : AppTextStyles.bodySmall.copyWith(
                      color: AppColor.greyDark,
                    )),
          ),
          Text(
            amount,
            style: amountStyle ??
                (isTotal
                    ? AppTextStyles.heading3.copyWith(color: AppColor.primary)
                    : AppTextStyles.bodyMedium),
          ),
        ],
      ),
    );
  }
}
