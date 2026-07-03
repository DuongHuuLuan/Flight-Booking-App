import 'package:flight_booking_app/domain/entities/flight.dart';
import 'package:flight_booking_app/domain/entities/flight_search_params.dart';
import 'package:flight_booking_app/domain/enums/trip_type.dart';
import 'package:flight_booking_app/domain/usecase/home/get_popular_flights_usecase.dart';
import 'package:flight_booking_app/domain/usecase/home/search_flights_usecsase.dart';
import 'package:flight_booking_app/domain/usecase/search/get_all_flights_usecase.dart';
import 'package:flight_booking_app/presentation/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetPopularFlightsUsecase getPopularFlights;
  final SearchFlightsUsecsase searchFlightsUsecase;
  final GetAllFlightsUsecase getAllFlightsUsecase;

  HomeCubit({
    required this.getPopularFlights,
    required this.searchFlightsUsecase,
    required this.getAllFlightsUsecase,
  }) : super(const HomeState());

  FlightSearchParams buildSearchParams({
    required TripType tripType,
    required String origin,
    required String destination,
    required int passengerCount,
    DateTime? departureDate,
  }) =>
      FlightSearchParams(
        tripType: tripType,
        origin: origin,
        destination: destination,
        departureDate: departureDate ?? DateTime.now(),
        passengerCount: passengerCount,
      );

  FlightSearchParams buildSearchParamsFromPopular(FlightEntity flight) =>
      FlightSearchParams(
        tripType: TripType.roundTrip,
        origin: flight.departureAirport.code,
        destination: flight.arrivalAirport.code,
        departureDate: flight.departureTime,
        passengerCount: 1,
      );

  Future<void> loadHomeData() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final popularEither = await getPopularFlights();
      popularEither.fold(
        (failure) => emit(state.copyWith(status: HomeStatus.failure)),
        (popular) =>
            emit(state.copyWith(status: HomeStatus.success, popular: popular)),
      );
    } catch (_) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> searchFlights(FlightSearchParams params) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final searchEither = await searchFlightsUsecase(params);

      searchEither.fold(
        (exception) => emit(state.copyWith(status: HomeStatus.failure)),
        (flights) {
          emit(state.copyWith(status: HomeStatus.success, popular: flights));
        },
      );
    } catch (_) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> getAllFlights() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final flights = await getAllFlightsUsecase();
      flights.fold(
        (exception) => emit(state.copyWith(status: HomeStatus.failure)),
        (flightsList) => emit(
          state.copyWith(status: HomeStatus.success, popular: flightsList),
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }
}
