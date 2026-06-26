import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/navigation_exp.dart';
import 'package:flight_booking_app/core/widgets/app_loading_overlay.dart';
import 'package:flight_booking_app/core/widgets/bottom_payment_bar.dart';
import 'package:flight_booking_app/presentation/booking_detail/cubit/booking_detail_cubit.dart';
import 'package:flight_booking_app/presentation/booking_detail/cubit/booking_detail_state.dart';
import 'package:flight_booking_app/presentation/booking_detail/view/widgets/flight_info_card.dart';
import 'package:flight_booking_app/presentation/booking_detail/view/widgets/passenger_info_card.dart';
import 'package:flight_booking_app/presentation/booking_detail/view/widgets/payment_breakdown_card.dart';
import 'package:flight_booking_app/presentation/booking_detail/view/widgets/ticket_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingDetailScreen extends StatefulWidget {
  static String get routerName => '/booking-detail';

  final String bookingId;
  final double basePrice;
  final int seatCount;

  const BookingDetailScreen({
    super.key,
    required this.bookingId,
    required this.basePrice,
    required this.seatCount,
  });

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Details", style: AppTextStyles.heading3),
        centerTitle: true,
      ),
      body: BlocConsumer<BookingDetailCubit, BookingDetailState>(
        listenWhen: (previous, current) =>
            previous.isLoading != current.isLoading ||
            previous.error != current.error,
        listener: (context, state) {
          if (state.isLoading) {
            context.showLoading();
          } else {
            context.hideLoading();
          }
          if (state.error != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error!),
                  backgroundColor: AppColor.error,
                ),
              );
            });
          }
        },
        builder: (context, state) {
          final detail = state.bookingDetail;
          if (detail == null) return const SizedBox.shrink();
          return SingleChildScrollView(
            child: Column(
              children: [
                FlightInfoCard(
                  flight: detail.flight,
                  cabinClass: detail.cabinClass,
                  price: detail.totalPrice,
                ),
                PassengerInfoCard(passengers: detail.passengers),
                TicketInfoCard(
                  flight: detail.flight,
                  selectedSeats: detail.selectedSeats,
                  cabinClass: detail.cabinClass,
                ),
                PaymentBreakdownCard(
                  basePrice: detail.passengers.isEmpty
                      ? 0
                      : detail.totalPrice / detail.passengers.length,
                  passengerCount: detail.passengers.length,
                  totalPrice: detail.totalPrice,
                ),
                const SizedBox(height: 100),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<BookingDetailCubit, BookingDetailState>(
        builder: (context, state) {
          final detail = state.bookingDetail;
          if (detail == null) return const SizedBox.shrink();
          return BottomPaymentBar(
            label: "Total Price",
            price: detail.totalPrice,
            buttonText: "Pay Now",
            onPressed: () {
              context.goToPaymentMethod();
            },
          );
        },
      ),
    );
  }
}
