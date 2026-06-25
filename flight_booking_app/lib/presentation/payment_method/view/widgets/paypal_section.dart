import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/widgets/app_card.dart';
import 'package:flight_booking_app/presentation/payment_method/cubit/payment_method_cubit.dart';
import 'package:flight_booking_app/presentation/payment_method/cubit/payment_method_state.dart';
import 'package:flutter/material.dart';

class PaypalSection extends StatelessWidget {
  final PaymentMethodCubit cubit;
  final PaymentMethodState state;

  const PaypalSection({super.key, required this.cubit, required this.state});

  @override
  Widget build(BuildContext context) {
    final isSelected = state.selectedMethod == PaymentMethodType.paypal;

    return AppCard(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => cubit.selectPaymentMethod(PaymentMethodType.paypal),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF003087),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    'PayPal',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColor.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Paypal',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: isSelected ? AppColor.primary : AppColor.grey400,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
