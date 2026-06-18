import 'package:flight_booking_app/domain/entities/flight.dart';
import 'package:flight_booking_app/domain/entities/flight_search_params.dart';
import 'package:flight_booking_app/domain/usecase/home/search_flights_usecsase.dart';
import 'package:flight_booking_app/domain/usecase/search/get_all_flights_usecase.dart';
import 'package:flight_booking_app/presentation/select_flight/cubit/select_flight_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectFlightCubit extends Cubit<SelectFlightState> {
  final GetAllFlightsUsecase getAllFlightsUsecase;
  final SearchFlightsUsecsase searchFlightsUsecsase;

  SelectFlightCubit({
    required this.getAllFlightsUsecase,
    required this.searchFlightsUsecsase,
  }) : super(SelectFlightState());

  Future<void> loadFlights(FlightSearchParams params) async {
    emit(state.copyWith(isLoading: true));

    final result = await getAllFlightsUsecase();

    result.fold(
      (exception) {
        return emit(state.copyWith(isLoading: false));
      },
      (flights) {
        final filtered = flights
            .where(
              (element) =>
                  element.departureAirport.code == params.origin &&
                  element.arrivalAirport.code == params.destination,
            )
            .toList();

        final prices = filtered.map((f) => f.price);
        final minP = prices.isEmpty
            ? 0.0
            : prices.reduce(
                (value, element) => value < element ? value : element,
              );
        final maxP = prices.isEmpty
            ? 10000.0
            : prices.reduce(
                (value, element) => value > element ? value : element,
              );

        emit(
          state.copyWith(
            isLoading: false,
            allFlights: filtered,
            filteredFlights: filtered,
            originAirport: filtered.isNotEmpty
                ? filtered.first.departureAirport
                : null,
            destinationAirport: filtered.isNotEmpty
                ? filtered.first.arrivalAirport
                : null,
            minPrice: minP,
            maxPrice: maxP,
            priceRange: RangeValues(minP, maxP),
          ),
        );
      },
    );
  }

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void applyFilters({
    required StopsFilter stops,
    required TimeFilter departureTime,
    required TimeFilter arrivalTime,
    required RangeValues priceRange,
  }) {
    var list = List<FlightEntity>.from(state.allFlights);
    if (stops == StopsFilter.nonStop) {
      list = list.where((f) => f.stops == 0).toList();
    } else if (stops == StopsFilter.oneStop) {
      list = list.where((f) => f.stops == 1).toList();
    }
    if (departureTime != TimeFilter.any) {
      list = list
          .where((f) => _timeSlot(f.departureTime) == departureTime)
          .toList();
    }
    if (arrivalTime != TimeFilter.any) {
      list = list
          .where((f) => _timeSlot(f.arrivalTime) == arrivalTime)
          .toList();
    }
    list = list
        .where((f) => f.price >= priceRange.start && f.price <= priceRange.end)
        .toList();
    emit(
      state.copyWith(
        filteredFlights: list,
        stops: stops,
        departureTime: departureTime,
        arrivalTime: arrivalTime,
        priceRange: priceRange,
      ),
    );
  }

  void clearFilters() {
    emit(
      state.copyWith(
        filteredFlights: state.allFlights,
        stops: StopsFilter.all,
        departureTime: TimeFilter.any,
        arrivalTime: TimeFilter.any,
        priceRange: RangeValues(state.minPrice, state.maxPrice),
      ),
    );
  }

  TimeFilter _timeSlot(DateTime t) {
    final h = t.hour;
    if (h >= 6 && h < 12) return TimeFilter.morning;
    if (h >= 12 && h < 18) return TimeFilter.afternoon;
    if (h >= 18 && h < 24) return TimeFilter.evening;
    return TimeFilter.night;
  }
}
