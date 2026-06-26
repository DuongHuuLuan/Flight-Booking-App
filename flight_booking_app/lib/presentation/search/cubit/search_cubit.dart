import 'dart:async';
import 'package:flight_booking_app/domain/usecase/search/get_all_flights_usecase.dart';
import 'package:flight_booking_app/presentation/search/cubit/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  final GetAllFlightsUsecase getAllFlights;
  Timer? _debounce;

  SearchCubit({required this.getAllFlights}) : super(const SearchState());

  Future<void> loadFlights() async {
    emit(state.copyWith(isLoading: true));
    final result = await getAllFlights();
    result.fold(
      (error) =>
          emit(state.copyWith(isLoading: false, error: error.toString())),
      (flights) => emit(
        state.copyWith(isLoading: false, allFlights: flights, filteredFlights: flights),
      ),
    );
  }

  void search(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (query.isEmpty) {
        emit(state.copyWith(filteredFlights: state.allFlights));
        return;
      }
      final lowerQuery = query.toLowerCase();
      emit(state.copyWith(
        filteredFlights: state.allFlights.where((flight) {
          return flight.departureAirport.code.toLowerCase().contains(lowerQuery) ||
              flight.departureAirport.city.toLowerCase().contains(lowerQuery) ||
              flight.arrivalAirport.code.toLowerCase().contains(lowerQuery) ||
              flight.arrivalAirport.city.toLowerCase().contains(lowerQuery) ||
              flight.airline.name.toLowerCase().contains(lowerQuery) ||
              flight.flightNumber.toLowerCase().contains(lowerQuery);
        }).toList(),
      ));
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
