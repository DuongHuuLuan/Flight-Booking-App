import 'package:flight_booking_app/domain/entities/flight.dart';

class SearchState {
  final bool isLoading;
  final List<FlightEntity> allFlights;
  final List<FlightEntity> filteredFlights;
  final String? error;

  const SearchState({
    this.isLoading = false,
    this.allFlights = const [],
    this.filteredFlights = const [],
    this.error,
  });

  SearchState copyWith({
    bool? isLoading,
    List<FlightEntity>? allFlights,
    List<FlightEntity>? filteredFlights,
    String? error,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      allFlights: allFlights ?? this.allFlights,
      filteredFlights: filteredFlights ?? this.filteredFlights,
      error: error,
    );
  }
}
