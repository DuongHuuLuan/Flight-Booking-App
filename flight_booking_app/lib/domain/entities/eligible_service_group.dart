import 'package:equatable/equatable.dart';
import 'package:flight_booking_app/domain/entities/seat/service_entity.dart';

class EligibleServiceGroup extends Equatable {
  final List<ServiceEntity> meals;
  final List<ServiceEntity> drinks;
  final List<ServiceEntity> baggage;
  final Map<String, int> limits;

  const EligibleServiceGroup({
    required this.meals,
    required this.drinks,
    required this.baggage,
    required this.limits,
  });

  @override
  List<Object?> get props => [meals, drinks, baggage, limits];
}
