import 'package:flight_booking_app/domain/entities/passenger_entity.dart';
import 'package:flight_booking_app/domain/entities/seat/service_entity.dart';
import 'package:flight_booking_app/domain/enums/age_group.dart';
import 'package:flight_booking_app/domain/usecase/passenger/create_passengers_usecase.dart';
import 'package:flight_booking_app/domain/usecase/passenger/update_passenger_usecase.dart';
import 'package:flight_booking_app/domain/usecase/service/get_eligible_services_usecase.dart';
import 'package:flight_booking_app/presentation/passenger/cubit/passenger_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PassengerCubit extends Cubit<PassengerState> {
  final CreatePassengersUseCase createPassengersUseCase;
  final UpdatePassengerUsecase updatePassengerUsecase;
  final GetEligibleServicesUsecase getEligibleServicesUsecase;

  PassengerCubit({
    required this.createPassengersUseCase,
    required this.updatePassengerUsecase,
    required this.getEligibleServicesUsecase,
  }) : super(const PassengerState());

  Future<void> loadBaggageOptions({
    required String flightId,
    required String zoneId,
  }) async {
    final result = await getEligibleServicesUsecase(
      flightId: flightId,
      zoneId: zoneId,
      ageGroup: AgeGroup.adult,
    );
    result.fold((error) {
      emit(state.copyWith(error: error.toString()));
    }, (group) {
      emit(state.copyWith(baggageOptions: group.baggage));
      _recompute();
    });
  }

  void _recompute() {
    final total = state.forms.fold<double>(0, (sum, f) {
      if (f.baggageLevel.isEmpty) return sum;
      final bag = state.baggageOptions.firstWhere(
        (b) => b.serviceId == f.baggageLevel,
        orElse: () => const ServiceEntity(
          serviceId: '', type: '', name: '', price: 0, maxPerPassenger: 0,
        ),
      );
      return sum + bag.price;
    });
    emit(state.copyWith(totalBaggagePrice: total));
  }

  void initForms(
    int total,
    List<String> ageGroupNames,
    List<String> seatLabels,
  ) {
    final ageGroups = ageGroupNames
        .map((s) => AgeGroup.values.firstWhere((ag) => ag.name == s))
        .toList();
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
    _recompute();
  }

  Future<bool> savePassengers({required String bookingId}) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final passengers = state.forms
          .map((f) => f.toEntity(id: '', bookingId: bookingId))
          .toList();

      final created = await createPassengersUseCase.execute(
        bookingId: bookingId,
        passengers: passengers,
      );
      emit(
        state.copyWith(isLoading: false, isSuccess: true, passengers: created),
      );
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

  List<Map<String, dynamic>> buildPassengerPayloads(
    List<PassengerEntity> created,
    List<String> seatZoneIds,
  ) {
    return state.forms.asMap().entries.map((e) {
      final i = e.key;
      final f = e.value;
      return {
        'index': i,
        'passengerId': created[i].id,
        'seatLabel': f.seatLabel,
        'zoneId': seatZoneIds.length > i ? seatZoneIds[i] : '',
        'ageGroup': f.ageGroup.name,
        'name': f.name,
        'mobilePhone': f.mobilePhone,
        'passportNumber': f.passportNumber,
        'nationality': f.nationality,
        'address': f.address,
        'email': f.email,
        'idNumber': f.idNumber,
        'baggageLevel': f.baggageLevel,
        'dateOfBirth': f.dateOfBirth?.toIso8601String(),
      };
    }).toList();
  }
}
