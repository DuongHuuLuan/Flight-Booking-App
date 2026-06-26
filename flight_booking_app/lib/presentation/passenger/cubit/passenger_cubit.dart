import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flight_booking_app/domain/entities/passenger_entity.dart';
import 'package:flight_booking_app/domain/usecase/passenger/create_passengers_usecase.dart';
import 'package:flight_booking_app/presentation/passenger/cubit/passenger_state.dart';

class PassengerCubit extends Cubit<PassengerState> {
  final CreatePassengersUseCase createPassengersUseCase;

  PassengerCubit({required this.createPassengersUseCase})
      : super(const PassengerState());

  Future<void> savePassengers({
    required String bookingId,
    required List<PassengerEntity> passengers,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await createPassengersUseCase.execute(
        bookingId: bookingId,
        passengers: passengers,
      );
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void reset() => emit(const PassengerState());
}
