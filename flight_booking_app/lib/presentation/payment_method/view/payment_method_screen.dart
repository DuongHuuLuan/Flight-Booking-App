import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/navigation_exp.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/widgets/app_alert_dialog.dart';
import 'package:flight_booking_app/core/widgets/app_elevated_button.dart';
import 'package:flight_booking_app/core/widgets/app_loading_overlay.dart';
import 'package:flight_booking_app/domain/entities/booking/booking_detail_entity.dart';
import 'package:flight_booking_app/presentation/payment_method/cubit/payment_method_cubit.dart';
import 'package:flight_booking_app/presentation/payment_method/cubit/payment_method_state.dart';
import 'package:flight_booking_app/presentation/payment_method/view/widgets/credit_card_section.dart';
import 'package:flight_booking_app/presentation/payment_method/view/widgets/paypal_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PaymentMethodScreen extends StatelessWidget {
  static String get routerName => '/payment-method';
  const PaymentMethodScreen({super.key});

  void _showSuccessDialog(BuildContext context, BookingDetailEntity booking) {
    showDialog(
      context: context,
      builder: (_) => AppAlertDialog(
        icon: Icons.check_circle,
        color: AppColor.primary,
        title: 'Booking Successful\nCompleted',
        titleStyle: AppTextStyles.heading3,
        message: "Thank your for choosing our service",
        messageStyle: AppTextStyles.bodySmall,
        buttonLabel: 'View Ticket',
        buttonLabelStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColor.white,
        ),
        onConfirm: () {
          Navigator.of(context).pop();
          context.goToBoardingPass(booking);
        },
        cancelLabel: 'Go to Home',
        cancelLabelStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColor.primary,
        ),
        borderColorCancel: AppColor.primary,
        onCancel: () => context.goToHome(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentMethodCubit, PaymentMethodState>(
      listenWhen: (previous, current) =>
          previous.isProcessing != current.isProcessing,
      listener: (context, state) {
        if (state.isProcessing) {
          context.showLoading();
        } else {
          context.hideLoading();
        }
      },
      builder: (context, state) {
        final cubit = context.read<PaymentMethodCubit>();
        final booking =
            (GoRouterState.of(context).extra
                    as Map<String, dynamic>?)?['booking']
                as BookingDetailEntity?;

        return Scaffold(
          backgroundColor: AppColor.background,
          appBar: AppBar(
            title: Text('Payment Methods', style: AppTextStyles.heading3),
            centerTitle: true,
            backgroundColor: AppColor.white,
            elevation: 0,
          ),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                  children: [
                    CreditCardSection(cubit: cubit, state: state),
                    const SizedBox(height: 20),
                    PaypalSection(cubit: cubit, state: state),
                  ],
                ),
          bottomNavigationBar: AppElevatedButton(
            height: MediaQuery.of(context).size.height * 0.06,
            label: 'Pay Now',
            onPressed: state.selectedCard == null || state.isProcessing
                ? null
                : () async {
                    final success = await cubit.processPayment(booking!.id);
                    if (success && context.mounted) {
                      _showSuccessDialog(context, booking);
                    }
                  },
          ).paddingOnly(bottom: 30, left: 20, right: 20),
        );
      },
    );
  }
}
