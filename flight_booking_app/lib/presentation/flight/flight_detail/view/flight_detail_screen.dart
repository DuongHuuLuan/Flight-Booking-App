import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/navigation_exp.dart';
import 'package:flight_booking_app/core/widgets/app_loading_overlay.dart';
import 'package:flight_booking_app/core/widgets/bottom_payment_bar.dart';
import 'package:flight_booking_app/presentation/flight/flight_detail/cubit/flight_detail_cubit.dart';
import 'package:flight_booking_app/presentation/flight/flight_detail/cubit/flight_detail_state.dart';
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
                      FlightSummaryCard(detail: detail),
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
                price: state.selectedCabinClass?.price ?? 0,
                onPressed: () async {
                  final flightId = state.flightDetail!.id;
                  final cabin = state.selectedCabinClass;
                  if (cabin != null && context.mounted) {
                    context.goToSelectSeat(
                      flightId: flightId,
                      cabinClass: cabin.cabinClass.name,
                      basePrice: cabin.price,
                    );
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
