import 'package:flight_booking_app/domain/entities/eligible_service_group.dart';

class ServiceSelectionState {
  final bool isLoading;
  final bool isSaving;
  final bool isSuccess;
  final EligibleServiceGroup? serviceGroup;
  final Map<String, int> tempSelections;
  final String? error;

  const ServiceSelectionState({
    this.isLoading = false,
    this.isSaving = false,
    this.isSuccess = false,
    this.serviceGroup,
    this.tempSelections = const {},
    this.error,
  });
  ServiceSelectionState copyWith({
    bool? isLoading,
    bool? isSaving,
    bool? isSuccess,
    EligibleServiceGroup? serviceGroup,
    Map<String, int>? tempSelections,
    String? error,
  }) {
    return ServiceSelectionState(
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      isSuccess: isSuccess ?? this.isSuccess,
      serviceGroup: serviceGroup ?? this.serviceGroup,
      tempSelections: tempSelections ?? this.tempSelections,
      error: error,
    );
  }
}
