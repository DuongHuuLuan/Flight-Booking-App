import 'package:equatable/equatable.dart';

class SeatZoneEntity extends Equatable {
  final String zoneId;
  final String zoneName;
  final double priceModifier;
  final String? colorHex;
  final int availableSeats;
  final double pricePerSeat;

  const SeatZoneEntity({
    required this.zoneId,
    required this.zoneName,
    required this.priceModifier,
    this.colorHex,
    required this.availableSeats,
    required this.pricePerSeat,
  });

  @override
  List<Object?> get props => [
    zoneId,
    zoneName,
    priceModifier,
    colorHex,
    availableSeats,
    pricePerSeat,
  ];
}
