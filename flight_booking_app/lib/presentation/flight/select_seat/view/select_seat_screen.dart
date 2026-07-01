import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/widgets/app_loading_overlay.dart';
import 'package:flight_booking_app/core/widgets/bottom_payment_bar.dart';
import 'package:flight_booking_app/domain/enums/age_group.dart';
import 'package:flight_booking_app/presentation/flight/select_seat/cubit/select_seat_cubit.dart';
import 'package:flight_booking_app/presentation/flight/select_seat/cubit/select_seat_state.dart';
import 'package:flight_booking_app/presentation/flight/select_seat/view/widgets/seat_map_view.dart';
import 'package:flight_booking_app/presentation/flight/select_seat/view/widgets/seat_status_legend.dart';
import 'package:flight_booking_app/presentation/passenger/view/passenger_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SelectSeatScreen extends StatelessWidget {
  static String get routerName => '/select-seat';

  final int adults;
  final int children;
  final int seniors;

  const SelectSeatScreen({
    super.key,
    this.adults = 1,
    this.children = 0,
    this.seniors = 0,
  });

  List<AgeGroup> get _ageGroups => [
    for (int i = 0; i < adults; i++) AgeGroup.adult,
    for (int i = 0; i < children; i++) AgeGroup.child,
    for (int i = 0; i < seniors; i++) AgeGroup.senior,
  ];

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

                SeatStatusLegend(
                  zoneColors: state.zones.map((z) => ZoneColorInfo(
                    color: parseZoneColor(z.colorHex),
                    name: z.zoneName,
                  )).toList(),
                ),

                const SizedBox(height: 32),
                Expanded(
                  child: SeatMapView(
                    state: state,
                    onSeatTap: (seatLabel) =>
                        cubit.toggleSeat(seatLabel, state.selectedZoneId ?? ""),
                  ),
                ),

                BottomPaymentBar(
                  label: state.selectedSeats.isEmpty
                      ? "No seat selected"
                      : "${state.selectedSeats.length} seat${state.selectedSeats.length > 1 ? 's' : ''} selected",
                  buttonText: "Continue",
                  price: state.totalPrice,
                  priceStyle: AppTextStyles.heading3.copyWith(
                    color: AppColor.black,
                  ),
                  onPressed: state.selectedSeats.isEmpty
                      ? null
                      : () async {
                          final bookingId = await cubit.confirmSeat();
                          if (bookingId != null && context.mounted) {
                            final ageGroups = _ageGroups;
                            final seatLabels = state.selectedSeats
                                .map((s) => s.seatLabel)
                                .toList();
                            context.push(
                              PassengerDetailScreen.routerName,
                              extra: {
                                'bookingId': bookingId,
                                'seatCount': state.selectedSeats.length,
                                'basePrice': state.basePrice,
                                'ageGroups': ageGroups
                                    .map((ag) => ag.name)
                                    .toList(),
                                'seatLabels': seatLabels,
                                'zoneId': state.selectedZoneId ?? '',
                                'flightId': cubit.flightId,
                              },
                            );
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
