import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

@JsonSerializable()
class BookingModel {
  final String id;
  final String flightId;
  final String cabinClass;
  final double totalPrice;
  final String status;
  final DateTime createdAt;
  final double? zonePriceTotal;
  final double? serviceTotal;
  final double? baggageTotal;

  BookingModel({
    required this.id,
    required this.flightId,
    required this.cabinClass,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    this.zonePriceTotal,
    this.serviceTotal,
    this.baggageTotal,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookingModelToJson(this);
}
