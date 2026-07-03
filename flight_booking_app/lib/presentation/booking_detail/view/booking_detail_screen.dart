import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/error_snack_bar.dart';
import 'package:flight_booking_app/core/utils/navigation_exp.dart';
import 'package:flight_booking_app/core/widgets/app_loading_overlay.dart';
import 'package:flight_booking_app/core/widgets/bottom_payment_bar.dart';
import 'package:flight_booking_app/presentation/booking_detail/cubit/booking_detail_cubit.dart';
import 'package:flight_booking_app/presentation/booking_detail/cubit/booking_detail_state.dart';
import 'package:flight_booking_app/presentation/booking_detail/view/widgets/flight_info_card.dart';
import 'package:flight_booking_app/presentation/booking_detail/view/widgets/passenger_info_card.dart';
import 'package:flight_booking_app/presentation/booking_detail/view/widgets/payment_breakdown_card_v2.dart';
import 'package:flight_booking_app/presentation/booking_detail/view/widgets/service_list_card.dart';
import 'package:flight_booking_app/presentation/booking_detail/view/widgets/ticket_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingDetailScreen extends StatefulWidget {
  static String get routerName => '/booking-detail';

  final String bookingId;
  final double totalPrice;
  final int seatCount;

  const BookingDetailScreen({
    super.key,
    required this.bookingId,
    required this.totalPrice,
    required this.seatCount,
  });

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  bool _priceBreakdownFetched = false;

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
            previous.error != current.error ||
            previous.bookingDetail != current.bookingDetail,
        listener: (context, state) {
          if (state.isLoading) {
            context.showLoading();
          } else {
            context.hideLoading();
          }
          if (state.bookingDetail != null && !_priceBreakdownFetched) {
            _priceBreakdownFetched = true;
            context.read<BookingDetailCubit>().loadPriceBreakdown(
              widget.bookingId,
            );
          }
          if (state.error != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.showError(state.error!);
            });
          }
        },
        builder: (context, state) {
          final detail = state.bookingDetail;
          if (detail == null) return const SizedBox.shrink();
          return SingleChildScrollView(
            child: Column(
              children: [
                FlightInfoCard(flight: detail.flight, price: detail.totalPrice),
                PassengerInfoCard(passengers: detail.passengers),
                TicketInfoCard(
                  flight: detail.flight,
                  selectedSeats: detail.selectedSeats,
                ),
                if (detail.services != null && detail.services!.isNotEmpty)
                  ServiceListCard(services: detail.services!),
                PriceBreakdownCardV2(state: state),
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
            price: state.grandTotal,
            buttonText: "Pay Now",
            onPressed: () {
              final grandTotal = state.grandTotal;

              context.goToPaymentMethod(
                totalPrice: grandTotal,
                booking: detail,
              );
            },
          );
        },
      ),
    );
  }
}
