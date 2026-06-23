import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/widgets/app_loading_overlay.dart';
import 'package:flight_booking_app/presentation/flight/flight_detail/cubit/flight_detail_cubit.dart';
import 'package:flight_booking_app/presentation/flight/flight_detail/cubit/flight_detail_state.dart';
import 'package:flight_booking_app/presentation/flight/flight_detail/view/widgets/bottom_payment_bar.dart';
import 'package:flight_booking_app/presentation/flight/flight_detail/view/widgets/cabin_class_selector.dart';
import 'package:flight_booking_app/presentation/flight/flight_detail/view/widgets/flight_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlightDetailScreen extends StatelessWidget {
  static String get routerName => '/flight-detail';

  final String flightId;
  const FlightDetailScreen({super.key, required this.flightId});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FlightDetailCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Flight Details", style: AppTextStyles.heading3),
        centerTitle: true,
      ),
      body: BlocConsumer<FlightDetailCubit, FlightDetailState>(
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
          if (state.flightDetail == null) {
            return const SizedBox.shrink();
          }
          final detail = state.flightDetail!;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FlightSummaryCard(detail: detail).paddingAll(16),
                      const SizedBox(height: 20),
                      CabinClassSelector(
                        cabinClasses: detail.cabinClass,
                        selected: state.selectedCabinClass,
                        onSelected: (c) => cubit.selectCabinClass(c),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
              BottomPaymentBar(
                totalPrice: state.selectedCabinClass?.price ?? 0,
                onSelectSeat: () async {
                  final success = await cubit.createBooking();
                  if (success && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Booking confirmed!'),
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
    );
  }
}
