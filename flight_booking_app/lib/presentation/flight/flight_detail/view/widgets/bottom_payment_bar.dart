import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class BottomPaymentBar extends StatelessWidget {
  final double totalPrice;
  final bool isLoading;
  final VoidCallback onSelectSeat;

  const BottomPaymentBar({
    super.key,
    required this.totalPrice,
    this.isLoading = false,
    required this.onSelectSeat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: const BoxDecoration(
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.greyLight,
            blurRadius: 2,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Price",
                    style: AppTextStyles.caption.copyWith(
                      color: AppColor.greyDark,
                    ),
                  ),
                  Text(
                    "\$${totalPrice.toStringAsFixed(0)}",
                    style: AppTextStyles.heading2.copyWith(
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.43,
              child: ElevatedButton(
                onPressed: isLoading ? null : onSelectSeat,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  foregroundColor: AppColor.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColor.white,
                        ),
                      )
                    : const Text(
                        "Select Seat",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
