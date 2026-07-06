import 'package:flight_booking_app/domain/entities/eligible_service_group.dart';
import 'package:flight_booking_app/domain/entities/seat/service_entity.dart';
import 'package:flight_booking_app/domain/enums/age_group.dart';
import 'package:flight_booking_app/domain/repositories/service_repository.dart';
import 'package:flight_booking_app/domain/usecase/service/assign_services_usecase.dart';
import 'package:flight_booking_app/domain/usecase/service/get_eligible_services_usecase.dart';
import 'package:flight_booking_app/presentation/services/cubit/service_selection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceSelectionCubit extends Cubit<ServiceSelectionState> {
  final GetEligibleServicesUsecase getEligibleServices;
  final AssignServicesUsecase assignServices;

  ServiceSelectionCubit({
    required this.getEligibleServices,
    required this.assignServices,
  }) : super(const ServiceSelectionState());

  void setZoneTotal(double total) {
    emit(state.copyWith(zoneTotal: total));
  }

  void setFormBaggageLevel(String level) {
    emit(state.copyWith(formBaggageLevel: level));
  }

  AgeGroup resolveAgeGroup(String name) =>
      AgeGroup.values.firstWhere((ag) => ag.name == name);

  Future<void> loadServices({
    required String flightId,
    required String zoneId,
    required AgeGroup ageGroup,
  }) async {
    emit(
      state.copyWith(isLoading: true, serviceGroup: null, clearIsSuccess: true),
    );
    final result = await getEligibleServices(
      flightId: flightId,
      zoneId: zoneId,
      ageGroup: ageGroup,
    );
    result.fold(
      (error) =>
          emit(state.copyWith(isLoading: false, error: error.toString())),
      (group) => emit(
        state.copyWith(
          isLoading: false,
          serviceGroup: group,
          tempSelections: _initSelections(group),
        ),
      ),
    );
  }

  Map<String, int> _initSelections(EligibleServiceGroup group) {
    final map = <String, int>{};
    for (final s in group.meals) {
      map[s.serviceId] = 0;
    }
    for (final s in group.drinks) {
      map[s.serviceId] = 0;
    }
    for (final s in group.baggage) {
      map[s.serviceId] = 0;
    }
    return map;
  }

  void toggleService(ServiceEntity service, int delta) {
    final current = state.tempSelections[service.serviceId] ?? 0;
    final next = current + delta;
    if (next < 0 || next > service.maxPerPassenger) return;
    final updated = Map<String, int>.from(state.tempSelections);
    if (service.type == 'baggage' && delta > 0) {
      final baggageIds =
          state.serviceGroup?.baggage.map((e) => e.serviceId).toList() ?? [];
      for (final id in baggageIds) {
        if (id != service.serviceId) {
          updated[id] = 0;
        }
      }
    }
    updated[service.serviceId] = next;
    emit(state.copyWith(tempSelections: updated));
  }

  int getSelectedCount(String type) {
    if (state.serviceGroup == null) return 0;
    final services = switch (type) {
      'meal' => state.serviceGroup!.meals,
      'drink' => state.serviceGroup!.drinks,
      'baggage' => state.serviceGroup!.baggage,
      _ => <ServiceEntity>[],
    };
    return services.fold(
      0,
      (sum, s) => sum + (state.tempSelections[s.serviceId] ?? 0),
    );
  }

  Future<bool> confirmServices({
    required String bookingId,
    required String passengerId,
    required String seatLabel,
    required String baggageLevel,
  }) async {
    emit(state.copyWith(isSaving: true));
    final baggageServiceIds =
        state.serviceGroup?.baggage.map((e) => e.serviceId).toList() ?? [];

    final selected = state.tempSelections.entries
        .where((e) => e.value > 0 && !baggageServiceIds.contains(e.key))
        .map((e) => e.key)
        .toList();

    final selectedBaggage = state.tempSelections.entries.firstWhere(
      (e) => baggageServiceIds.contains(e.key) && e.value > 0,
      orElse: () => const MapEntry('', 0),
    );

    final input = PassengerServiceInput(
      passengerId: passengerId,
      seatLabel: seatLabel,
      serviceIds: selected,
      baggageLevel: selectedBaggage.key.isNotEmpty
          ? selectedBaggage.key
          : baggageLevel,
    );

    final result = await assignServices(
      bookingId: bookingId,
      passengerServices: [input],
    );
    return result.fold(
      (error) {
        emit(state.copyWith(isSaving: false, error: error.toString()));
        return false;
      },
      (_) {
        final accSvc = state.accumulatedServicePrice + state.serviceTotal;
        final accBag = state.accumulatedBaggagePrice + state.baggageTotal;
        emit(
          state.copyWith(
            isSaving: false,
            isSuccess: true,
            serviceGroup: null,
            tempSelections: const {},
            accumulatedServicePrice: accSvc,
            accumulatedBaggagePrice: accBag,
          ),
        );
        return true;
      },
    );
  }

  void reset() => emit(const ServiceSelectionState());
}
