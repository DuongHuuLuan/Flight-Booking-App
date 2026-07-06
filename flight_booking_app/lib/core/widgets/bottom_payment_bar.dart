import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class BottomPaymentBar extends StatelessWidget {
  final String? label;
  final double? price;
  final String? buttonText;
  final TextStyle? buttonTextStyle;
  final VoidCallback? onPressed;
  final bool? showShadow;
  final String? currency;
  final TextStyle? priceStyle;
  final TextStyle? labelStyle;
  final Widget? secondaryButton;

  const BottomPaymentBar({
    super.key,
    this.label,
    this.price,
    this.buttonText,
    this.buttonTextStyle,
    this.onPressed,
    this.showShadow,
    this.currency,
    this.priceStyle,
    this.labelStyle,
    this.secondaryButton,
  });

  @override
  Widget build(BuildContext context) {
    final displayLabel = label ?? "Total Price";
    final displayPrice = price ?? 0;
    final displayButtonText = buttonText ?? "Continue";
    final displayCurrency = currency ?? "\$";
    final hasShadow = showShadow ?? true;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: BoxDecoration(
        color: AppColor.white,
        boxShadow: hasShadow
            ? const [
                BoxShadow(
                  color: AppColor.greyLight,
                  blurRadius: 2,
                  offset: Offset(0, -2),
                ),
              ]
            : null,
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if(secondaryButton != null) ...[
              secondaryButton!,
              const SizedBox(width: 12,),
            ],
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayLabel,
                    style:
                        labelStyle ??
                        AppTextStyles.caption.copyWith(
                          color: AppColor.greyDark,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$displayCurrency${displayPrice.toStringAsFixed(0)}",
                    style:
                        priceStyle ??
                        AppTextStyles.heading2.copyWith(
                          color: AppColor.primary,
                        ),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: Responsive.size(
                context.screenWidth,
                factor: 0.43,
                min: 150,
                max: 240,
              ),
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  foregroundColor: AppColor.white,
                  disabledBackgroundColor: AppColor.greyLight,
                  disabledForegroundColor: AppColor.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  displayButtonText,
                  style:
                      buttonTextStyle ??
                      AppTextStyles.button.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
