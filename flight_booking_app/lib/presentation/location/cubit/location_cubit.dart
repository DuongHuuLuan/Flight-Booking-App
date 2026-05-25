import 'package:flight_booking_app/domain/usecase/auth/get_country_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/get_city_usecase.dart';
import 'package:flight_booking_app/presentation/location/cubit/location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationCubit extends Cubit<LocationState> {
  final GetCountryUsecase getCountryUsecase;
  final GetCityUsecase getCityUsecase;

  LocationCubit({required this.getCountryUsecase, required this.getCityUsecase})
    : super(LocationInitial());

  Future<void> loadCountries() async {
    emit(LocationLoading());
    final failureOrSuccess = await getCountryUsecase();

    failureOrSuccess.fold((exception) {
      final message = exception.toString().toLowerCase();
      if (message.contains('network')) {
        emit(LocationFailed('Network error.'));
      } else if (message.contains('timeout')) {
        emit(LocationFailed('The data loading time has expired'));
      } else {
        emit(
          LocationFailed(
            'Error loading data: ${message.replaceAll("Exception:", "")}',
          ),
        );
      }
    }, (r) => emit(LocationDataLoaded(r, [])));
  }

  Future<void> loadCities(String country) async {
    final currentState = state;
    if (currentState is LocationDataLoaded) {
      emit(LocationLoading());
      final failureOrSuccess = await getCityUsecase(country);
      failureOrSuccess.fold(
        (exception) {
          final message = exception.toString().toLowerCase();
          if (message.contains('network')) {
            emit(LocationFailed('Network connection error loading city list.'));
          } else if (message.contains('timeout')) {
            emit(LocationFailed('Time up while loading city data.'));
          } else {
            emit(
              LocationFailed(
                'Error loading data city: ${message.replaceAll("Exception:", "")}',
              ),
            );
          }
        },
        (r) {
          emit(LocationDataLoaded(currentState.countries, r));
        },
      );
    }
  }
}
