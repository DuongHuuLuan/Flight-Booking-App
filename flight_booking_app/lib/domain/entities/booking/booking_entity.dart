import 'package:equatable/equatable.dart';

class BookingEntity extends Equatable {
  final String id;
  final String flightId;
  final double totalPrice;
  final String status;
  final DateTime createdAt;
  final double? zonePriceTotal;
  final double? serviceTotal;
  final double? baggageTotal;

  const BookingEntity({
    required this.id,
    required this.flightId,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    this.zonePriceTotal,
    this.serviceTotal,
    this.baggageTotal,
  });

  @override
  List<Object?> get props => [
    id,
    flightId,
    totalPrice,
    status,
    createdAt,
    zonePriceTotal,
    serviceTotal,
    baggageTotal,
  ];
}
