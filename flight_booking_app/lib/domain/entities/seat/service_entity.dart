import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  final String serviceId;
  final String type;
  final String name;
  final double price;
  final int maxPerPassenger;
  final String? description;

  const ServiceEntity({
    required this.serviceId,
    required this.type,
    required this.name,
    required this.price,
    required this.maxPerPassenger,
    this.description,
  });

  @override
  List<Object?> get props => [
    serviceId,
    type,
    name,
    price,
    maxPerPassenger,
    description,
  ];
}
