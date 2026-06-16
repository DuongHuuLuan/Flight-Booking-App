import 'package:flight_booking_app/core/utils/navigation_exp.dart';
import 'package:flight_booking_app/presentation/select_flight/view/widgets/date_selector_bar.dart';
import 'package:flight_booking_app/presentation/select_flight/view/widgets/filter_bottom_sheet.dart';
import 'package:flight_booking_app/presentation/select_flight/view/widgets/flight_ticket_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/presentation/select_flight/cubit/select_flight_cubit.dart';
import 'package:flight_booking_app/presentation/select_flight/cubit/select_flight_state.dart';

class SelectFlightScreen extends StatelessWidget {
  static String get routerName => '/select-flight';
  const SelectFlightScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goToHome(),
        ),
        title: const Text("Select Flight"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => FilterBottomSheet.show(context),
          ),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: BlocBuilder<SelectFlightCubit, SelectFlightState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              _RouteInfoBar(),
              DateSelectorBar(
                selectedDate: state.selectedDate,
                onDateSelected: (date) {
                  context.read<SelectFlightCubit>().selectDate(date);
                },
              ),
              const SizedBox(height: 8),
              if (state.filteredFlights.isEmpty)
                const Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.flight, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          "No flights found",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 20),
                    itemCount: state.filteredFlights.length,
                    itemBuilder: (_, i) =>
                        FlightTicketCard(flight: state.filteredFlights[i]),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _RouteInfoBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.flight_takeoff, color: AppColor.primary, size: 18),
          const SizedBox(width: 6),
          const Text("Dubai (DXB)", style: AppTextStyles.bodyMedium),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColor.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                "16h 30m",
                style: TextStyle(
                  color: AppColor.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const Text("Auckland (AKL)", style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
}
