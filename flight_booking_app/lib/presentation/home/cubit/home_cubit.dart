import 'package:flight_booking_app/domain/Entities/flight_search_params.dart';
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
        (flight) {
          emit(state.copyWith(status: HomeStatus.success, popular: flight));
        },
      );
    } catch (_) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> getAllFlights() async {
    try {
      final flights = await getAllFlightsUsecase();

      flights.fold(
        (exception) => emit(state.copyWith(status: HomeStatus.failure)),
        (flight) =>
            emit(state.copyWith(status: HomeStatus.success, popular: flight)),
      );
    } catch (_) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }
}
