import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/navigation_exp.dart';
import 'package:flight_booking_app/presentation/select_flight/cubit/select_flight_cubit.dart';
import 'package:flight_booking_app/presentation/select_flight/cubit/select_flight_state.dart';
import 'package:flight_booking_app/presentation/select_flight/view/widgets/date_selector_bar.dart';
import 'package:flight_booking_app/presentation/select_flight/view/widgets/filter_bottom_sheet.dart';
import 'package:flight_booking_app/presentation/select_flight/view/widgets/flight_ticket_card.dart';
import 'package:flight_booking_app/presentation/select_flight/view/widgets/widgets_router_info/router_info_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectFlightScreen extends StatelessWidget {
  static String get routerName => '/select-flight';
  const SelectFlightScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SelectFlightCubit, SelectFlightState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                Stack(
                  children: [
                    RouteInfoBar(
                      origin: state.originAirport,
                      destination: state.destinationAirport,
                      duration: state.filteredFlights.isNotEmpty
                          ? state.filteredFlights.first.duration
                          : null,
                    ),

                    Positioned(
                      top: 8,
                      left: 4,
                      right: 4,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: AppColor.white,
                            ),
                            onPressed: () => context.goToHome(),
                          ),
                          Expanded(
                            child: Text(
                              "Select Flight",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColor.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.tune, color: AppColor.white),
                            onPressed: () => FilterBottomSheet.show(context),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.more_vert,
                              color: AppColor.white,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                DateSelectorBar(
                  selectedDate: state.selectedDate,
                  onDateSelected: (date) {
                    context.read<SelectFlightCubit>().selectDate(date);
                  },
                ),

                const SizedBox(height: 8),

                Expanded(
                  child: state.filteredFlights.isEmpty
                      ? const Center(child: Text("No flights found"))
                      : ListView.builder(
                          padding: const EdgeInsets.only(top: 8, bottom: 20),
                          itemCount: state.filteredFlights.length,
                          itemBuilder: (_, i) => FlightTicketCard(
                            flight: state.filteredFlights[i],
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
