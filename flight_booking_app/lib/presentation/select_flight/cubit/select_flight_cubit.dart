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

        final selectedDate = params.departureDate;
        final dateFiltered = filtered
            .where(
              (element) =>
                  element.departureTime.year == selectedDate.year &&
                  element.departureTime.month == selectedDate.month &&
                  element.departureTime.day == selectedDate.day,
            )
            .toList();
        emit(
          state.copyWith(
            isLoading: false,
            allFlights: filtered,
            filteredFlights: dateFiltered,
            selectedDate: params.departureDate,
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

  void selectFlight(FlightEntity flight) {
    emit(state.copyWith(selectedFlight: flight));
  }

  void selectDate(DateTime date) {
    applyFilters(
      stops: state.stops,
      departureTime: state.departureTime,
      arrivalTime: state.arrivalTime,
      priceRange: state.priceRange,
      selectedDate: date,
    );
  }

  void applyFilters({
    required StopsFilter stops,
    required TimeFilter departureTime,
    required TimeFilter arrivalTime,
    required RangeValues priceRange,
    DateTime? selectedDate,
  }) {
    var list = List<FlightEntity>.from(state.allFlights);

    final date = selectedDate ?? state.selectedDate;
    list = list
        .where(
          (element) =>
              element.departureTime.year == date.year &&
              element.departureTime.month == date.month &&
              element.departureTime.day == date.day,
        )
        .toList();

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
        selectedDate: date,
      ),
    );
  }

  void clearFilters() {
    var list = state.allFlights
        .where(
          (f) =>
              f.departureTime.year == state.selectedDate.year &&
              f.departureTime.month == state.selectedDate.month &&
              f.departureTime.day == state.selectedDate.day,
        )
        .toList();

    emit(
      state.copyWith(
        filteredFlights: list,
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
