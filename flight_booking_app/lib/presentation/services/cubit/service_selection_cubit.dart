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

  Future<void> loadServices({
    required String zoneId,
    required AgeGroup ageGroup,
  }) async {
    emit(state.copyWith(isLoading: true));
    final result = await getEligibleServices(
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
  }) async {
    emit(state.copyWith(isSaving: true));
    final selected = state.tempSelections.entries
        .where((e) => e.value > 0)
        .map((e) => e.key)
        .toList();

    final input = PassengerServiceInput(
      passengerId: passengerId,
      seatLabel: seatLabel,
      serviceIds: selected,
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
        emit(state.copyWith(isSaving: false, isSuccess: true));
        return true;
      },
    );
  }

  void reset() => emit(const ServiceSelectionState());
}
