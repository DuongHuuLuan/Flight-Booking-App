import 'package:json_annotation/json_annotation.dart';

part 'seat_zone_model.g.dart';

@JsonSerializable()
class SeatZoneModel {
  final String zoneId;
  final String zoneName;
  final double priceModifier;
  final String? colorHex;
  final int availableSeats;
  final double pricePerSeat;

  const SeatZoneModel({
    required this.zoneId,
    required this.zoneName,
    required this.priceModifier,
    this.colorHex,
    required this.availableSeats,
    required this.pricePerSeat,
  });

  factory SeatZoneModel.fromJson(Map<String, dynamic> json) =>
      _$SeatZoneModelFromJson(json);
  Map<String, dynamic> toJson() => _$SeatZoneModelToJson(this);
}
