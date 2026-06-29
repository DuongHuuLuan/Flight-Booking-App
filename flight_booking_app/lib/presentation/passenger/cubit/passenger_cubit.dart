import 'package:flight_booking_app/domain/enums/age_group.dart';
import 'package:flight_booking_app/domain/usecase/passenger/create_passengers_usecase.dart';
import 'package:flight_booking_app/domain/usecase/passenger/update_passenger_usecase.dart';
import 'package:flight_booking_app/presentation/passenger/cubit/passenger_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PassengerCubit extends Cubit<PassengerState> {
  final CreatePassengersUseCase createPassengersUseCase;
  final UpdatePassengerUsecase updatePassengerUsecase;

  PassengerCubit({
    required this.createPassengersUseCase,
    required this.updatePassengerUsecase,
  }) : super(const PassengerState());

  void initForms(int total, List<AgeGroup> ageGroups, List<String> seatLabels) {
    final forms = List.generate(
      total,
      (i) => PassengerFormData(
        seatLabel: seatLabels.length > i ? seatLabels[i] : '',
        ageGroup: ageGroups.length > i ? ageGroups[i] : AgeGroup.adult,
      ),
    );
    emit(state.copyWith(forms: forms, ageGroups: ageGroups));
  }

  void updateField(int index, String field, dynamic value) {
    final forms = List<PassengerFormData>.from(state.forms);
    forms[index] = forms[index].copyWithField(field, value);
    emit(state.copyWith(forms: forms));
  }

  Future<bool> savePassengers({required String bookingId}) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final passengers = state.forms
          .map((f) => f.toEntity(id: '', bookingId: bookingId))
          .toList();

      await createPassengersUseCase.execute(
        bookingId: bookingId,
        passengers: passengers,
      );
      emit(state.copyWith(isLoading: false, isSuccess: true));
      return true;
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
      return false;
    }
  }

  Future<bool> updatePassenger({
    required String bookingId,
    required String passengerId,
    required int formIndex,
  }) async {
    final form = state.forms[formIndex];
    final data = form.toMap();
    final result = await updatePassengerUsecase(
      bookingId: bookingId,
      passengerId: passengerId,
      data: data,
    );
    return result.fold((error) {
      emit(state.copyWith(error: error.toString()));
      return false;
    }, (_) => true);
  }

  void reset() => emit(const PassengerState());
}
