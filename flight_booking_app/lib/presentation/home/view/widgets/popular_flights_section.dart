import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/navigation_exp.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/domain/entities/flight_search_params.dart';
import 'package:flight_booking_app/domain/enums/trip_type.dart';
import 'package:flight_booking_app/presentation/home/cubit/home_cubit.dart';
import 'package:flight_booking_app/presentation/home/cubit/home_state.dart';
import 'package:flight_booking_app/presentation/home/view/widgets/polular_flights_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularFlightsSection extends StatelessWidget {
  const PopularFlightsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Popular Flights", style: AppTextStyles.heading3),
                TextButton(
                  onPressed: () {
                    context.read<HomeCubit>().loadHomeData();
                  },
                  child: Text(
                    "See All",
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColor.primary,
                    ),
                  ),
                ),
              ],
            ),

            if (state.status == HomeStatus.loading)
              const SizedBox.shrink()
            else if (state.status == HomeStatus.failure)
              Center(
                child: Column(
                  children: [
                    Text(
                      "Failure to load Flights",
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColor.error,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<HomeCubit>().loadHomeData();
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              )
            else if (state.popular.isEmpty)
              Center(
                child: Text(
                  "No popular flights",
                  style: AppTextStyles.bodySmall.copyWith(color: AppColor.grey),
                ),
              ).paddingVertical(20)
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemCount: state.popular.length,
                itemBuilder: (context, index) {
                  final flight = state.popular[index];

                  return PopularFlightCard(
                    flight: flight,
                    onTap: () {
                      final params = FlightSearchParams(
                        tripType: TripType.roundTrip,
                        origin: flight.departureAirport.code,
                        destination: flight.arrivalAirport.code,
                        departureDate: flight.departureTime,
                        passengerCount: 1,
                        cabinClass: flight.cabinClass,
                      );

                      context.goToSelectFlight(params);
                    },
                  );
                },
              ),
          ],
        ).paddingHorizontal(16);
      },
    );
  }
}
