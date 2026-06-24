import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/widgets/app_loading_overlay.dart';
import 'package:flight_booking_app/core/widgets/bottom_payment_bar.dart';
import 'package:flight_booking_app/presentation/flight/select_seat/cubit/select_seat_cubit.dart';
import 'package:flight_booking_app/presentation/flight/select_seat/cubit/select_seat_state.dart';
import 'package:flight_booking_app/presentation/flight/select_seat/view/widgets/seat_map_view.dart';
import 'package:flight_booking_app/presentation/flight/select_seat/view/widgets/seat_status_legend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectSeatScreen extends StatelessWidget {
  static String get routerName => '/select-seat';
  const SelectSeatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SelectSeatCubit>();
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: BlocConsumer<SelectSeatCubit, SelectSeatState>(
          listenWhen: (previous, current) =>
              previous.isLoading != current.isLoading ||
              previous.isBooking != current.isBooking,
          listener: (context, state) {
            if (state.isLoading || state.isBooking) {
              context.showLoading();
            } else {
              context.hideLoading();
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                    Expanded(
                      child: Text(
                        "Select Seats",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.heading3,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ).paddingHorizontal(20).paddingVertical(16),

                const SizedBox(height: 8),

                const SeatStatusLegend(),

                const SizedBox(height: 32),
                Expanded(
                  child: SeatMapView(state: state, onSeatTap: cubit.toggleSeat),
                ),

                BottomPaymentBar(
                  label: state.selectedSeat ?? "No seat selected",
                  buttonText: "Continue",
                  price: state.basePrice,
                  priceStyle: AppTextStyles.heading3.copyWith(
                    color: AppColor.black,
                  ),
                  onPressed: state.selectedSeat == null
                      ? null
                      : () async {
                          final bookingId = await cubit.confirmSeat();
                          if (bookingId != null && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Seat confirmed!'),
                                backgroundColor: AppColor.success,
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
