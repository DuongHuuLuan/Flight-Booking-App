import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/widgets/app_card.dart';
import 'package:flight_booking_app/presentation/booking_detail/view/widgets/price_row.dart';
import 'package:flutter/material.dart';

class PaymentBreakdownCard extends StatelessWidget {
  final double basePrice;
  final int passengerCount;
  final double totalPrice;

  const PaymentBreakdownCard({
    super.key,
    required this.basePrice,
    required this.passengerCount,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Payment", style: AppTextStyles.heading3).paddingAll(16),
          const Divider(height: 1, color: AppColor.border),
          PriceRow(
            label: "Base Price (x $passengerCount)",
            amount: "\$${basePrice.toStringAsFixed(0)}",
          ),
          PriceRow(label: "Discount", amount: "\$0"),
          const Divider(height: 1, color: AppColor.border),
          PriceRow(
            label: "Total",
            amount: "\$${totalPrice.toStringAsFixed(0)}",
            isTotal: true,
          ),
        ],
      ),
    );
  }
}
