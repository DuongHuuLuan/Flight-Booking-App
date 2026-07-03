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
  int get _totalPassengers => adults + children + seniors;

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

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: state.zones.map((zone) {
                      final isActive = zone.zoneId == state.selectedZoneId;
                      final color = parseZoneColor(zone.colorHex);
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => cubit.selectZone(zone.zoneId),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? color.withValues(alpha: 0.15)
                                  : AppColor.grey100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isActive ? color : AppColor.grey300,
                                width: isActive ? 2 : 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  zone.zoneName,
                                  style: AppTextStyles.caption.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: isActive ? color : AppColor.greyDark,
                                  ),
                                ),
                                Text(
                                  '${zone.pricePerSeat.toStringAsFixed(0)}₫',
                                  style: AppTextStyles.caption.copyWith(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

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
                      : "${state.selectedSeats.length} of $_totalPassengers seats selected",
                  buttonText: "Continue",
                  price: state.totalPrice,
                  priceStyle: AppTextStyles.heading3.copyWith(
                    color: AppColor.black,
                  ),
                  onPressed: state.selectedSeats.length != _totalPassengers
                      ? null
                      : () async {
                          final bookingId = await cubit.confirmSeat();
                          if (bookingId != null && context.mounted) {
                            final ageGroups = _ageGroups;
                            final seatLabels = state.selectedSeats
                                .map((s) => s.seatLabel)
                                .toList();
                            final seatZoneIds = state.selectedSeats
                                .map((e) => e.zoneId)
                                .toList();
                            context.push(
                              PassengerDetailScreen.routerName,
                              extra: {
                                'bookingId': bookingId,
                                'seatCount': state.selectedSeats.length,
                                'basePrice': state.basePrice,
                                'totalPrice': state.totalPrice,
                                'ageGroups': ageGroups
                                    .map((ag) => ag.name)
                                    .toList(),
                                'seatLabels': seatLabels,
                                'seatZoneIds': seatZoneIds,
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
