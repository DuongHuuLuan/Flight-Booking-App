import 'package:flight_booking_app/domain/entities/eligible_service_group.dart';
import 'package:flight_booking_app/domain/entities/seat/service_entity.dart';

class ServiceSelectionState {
  final bool isLoading;
  final bool isSaving;
  final bool isSuccess;
  final EligibleServiceGroup? serviceGroup;
  final Map<String, int> tempSelections;
  final String? error;
  final double accumulatedServicePrice;
  final double accumulatedBaggagePrice;
  final double zoneTotal;
  final String formBaggageLevel;

  const ServiceSelectionState({
    this.isLoading = false,
    this.isSaving = false,
    this.isSuccess = false,
    this.serviceGroup,
    this.tempSelections = const {},
    this.error,
    this.accumulatedServicePrice = 0,
    this.accumulatedBaggagePrice = 0,
    this.zoneTotal = 0,
    this.formBaggageLevel = '',
  });

  double get serviceTotal {
    if (serviceGroup == null) return 0;
    double total = 0;
    for (final entry in tempSelections.entries) {
      final service = serviceGroup!.meals.firstWhere(
        (s) => s.serviceId == entry.key,
        orElse: () => serviceGroup!.drinks.firstWhere(
          (s) => s.serviceId == entry.key,
          orElse: () => const ServiceEntity(
            serviceId: '', type: '', name: '', price: 0, maxPerPassenger: 0,
          ),
        ),
      );
      total += service.price * entry.value;
    }
    return total;
  }

  double get baggageTotal {
    double total = 0;
    if (serviceGroup != null && formBaggageLevel.isNotEmpty) {
      final formBaggagePrice = serviceGroup!.baggage
          .firstWhere(
            (b) => b.serviceId == formBaggageLevel,
            orElse: () => const ServiceEntity(
              serviceId: '', type: '', name: '', price: 0, maxPerPassenger: 0,
            ),
          )
          .price;
      total += formBaggagePrice;
    }
    if (serviceGroup != null) {
      for (final entry in tempSelections.entries) {
        final svc = serviceGroup!.baggage.firstWhere(
          (s) => s.serviceId == entry.key,
          orElse: () => const ServiceEntity(
            serviceId: '', type: '', name: '', price: 0, maxPerPassenger: 0,
          ),
        );
        if (svc.serviceId.isNotEmpty) {
          total += svc.price * entry.value;
        }
      }
    }
    return total;
  }

  double get grandTotal =>
      zoneTotal +
      accumulatedServicePrice +
      accumulatedBaggagePrice +
      serviceTotal +
      baggageTotal;

  ServiceSelectionState copyWith({
    bool? isLoading,
    bool? isSaving,
    bool? isSuccess,
    bool clearIsSuccess = false,
    EligibleServiceGroup? serviceGroup,
    Map<String, int>? tempSelections,
    String? error,
    double? accumulatedServicePrice,
    double? accumulatedBaggagePrice,
    double? zoneTotal,
    String? formBaggageLevel,
  }) {
    return ServiceSelectionState(
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      isSuccess: clearIsSuccess ? false : (isSuccess ?? this.isSuccess),
      serviceGroup: serviceGroup ?? this.serviceGroup,
      tempSelections: tempSelections ?? this.tempSelections,
      error: error,
      accumulatedServicePrice:
          accumulatedServicePrice ?? this.accumulatedServicePrice,
      accumulatedBaggagePrice:
          accumulatedBaggagePrice ?? this.accumulatedBaggagePrice,
      zoneTotal: zoneTotal ?? this.zoneTotal,
      formBaggageLevel: formBaggageLevel ?? this.formBaggageLevel,
    );
  }
}
