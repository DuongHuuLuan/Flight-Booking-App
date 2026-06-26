import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/responsive.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/domain/entities/payment_method_entity.dart';
import 'package:flight_booking_app/presentation/payment_method/cubit/payment_method_cubit.dart';
import 'package:flight_booking_app/presentation/payment_method/cubit/payment_method_state.dart';
import 'package:flight_booking_app/presentation/payment_method/view/add_card_screen.dart';
import 'package:flight_booking_app/presentation/payment_method/view/widgets/add_new_card_tile.dart';
import 'package:flight_booking_app/presentation/payment_method/view/widgets/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreditCardSection extends StatelessWidget {
  final PaymentMethodCubit cubit;
  final PaymentMethodState state;

  const CreditCardSection({
    super.key,
    required this.cubit,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = state.selectedMethod == PaymentMethodType.creditCard;

    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () =>
                    cubit.selectPaymentMethod(PaymentMethodType.creditCard),
                child: Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: isSelected ? AppColor.primary : AppColor.grey400,
                  size: 22,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 28,
                height: 18,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 1,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEB001B),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 1,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF79E1B),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Credit/Debit Card',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          if (isSelected) ...[
            const SizedBox(height: 16),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: state.savedCards.length,
                separatorBuilder: (_, _) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final card = state.savedCards[index];
                  return GestureDetector(
                    onTap: () => cubit.selectCard(card),
                    child: CreditCardWidget(
                      card: card,
                      width: Responsive.cardWidth(context.screenWidth),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            AddNewCardTile(
              onTap: () async {
                final result = await context.push<PaymentMethodEntity>(
                  AddCardScreen.routerName,
                );
                if (result != null && context.mounted) {
                  cubit.addCard(result);
                }
              },
            ),
          ],
        ],
      ).paddingAll(20),
    );
  }
}
