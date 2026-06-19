import 'package:flight_booking_app/domain/usecase/auth/get_city_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/get_country_usecase.dart';
import 'package:flight_booking_app/presentation/location/cubit/location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationCubit extends Cubit<LocationState> {
  final GetCountryUsecase getCountryUsecase;
  final GetCityUsecase getCityUsecase;

  LocationCubit({required this.getCountryUsecase, required this.getCityUsecase})
    : super(LocationState());

  Future<void> loadCountries() async {
    emit(state.copyWith(status: LocationStatus.loading));
    final failureOrSuccess = await getCountryUsecase();

    failureOrSuccess.fold(
      (exception) {
        final message = exception.toString().toLowerCase();
        if (message.contains('network')) {
          emit(
            state.copyWith(
              status: LocationStatus.failure,
              errorMessage: "Network error.",
            ),
          );
        } else if (message.contains('timeout')) {
          emit(
            state.copyWith(
              status: LocationStatus.failure,
              errorMessage: 'The data loading time has expired',
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: LocationStatus.failure,
              errorMessage:
                  'Error loading data: ${message.replaceAll("Exception:", "")}',
            ),
          );
        }
      },
      (r) => emit(
        state.copyWith(
          status: LocationStatus.dataLoaded,
          countries: r,
          cities: [],
        ),
      ),
    );
  }

  Future<void> loadCities(String country) async {
    final currentState = state;
    if (currentState.status == LocationStatus.dataLoaded) {
      emit(state.copyWith(status: LocationStatus.loading));
      final failureOrSuccess = await getCityUsecase(country);
      failureOrSuccess.fold(
        (exception) {
          final message = exception.toString().toLowerCase();
          if (message.contains('network')) {
            emit(
              state.copyWith(
                status: LocationStatus.failure,
                errorMessage: 'Network connection error loading city list.',
              ),
            );
          } else if (message.contains('timeout')) {
            emit(
              state.copyWith(
                status: LocationStatus.failure,
                errorMessage: 'Time up while loading city data.',
              ),
            );
          } else {
            emit(
              state.copyWith(
                status: LocationStatus.failure,
                errorMessage:
                    'Error loading data city: ${message.replaceAll("Exception:", "")}',
              ),
            );
          }
        },
        (r) {
          emit(state.copyWith(cities: r, status: LocationStatus.dataLoaded));
        },
      );
    }
  }
}
