import 'package:equatable/equatable.dart';

class SeatEntity extends Equatable {
  final String seatLabel;
  final String cabinClass;
  final int rowNumber;
  final int position;
  final String status;
  final String? zoneId;
  final String? zoneName;
  final double? zonePrice;

  const SeatEntity({
    required this.seatLabel,
    required this.cabinClass,
    required this.rowNumber,
    required this.position,
    required this.status,
    this.zoneId,
    this.zoneName,
    this.zonePrice,
  });

  @override
  List<Object?> get props => [
    seatLabel,
    cabinClass,
    rowNumber,
    position,
    status,
    zoneId,
    zoneName,
    zonePrice,
  ];
}
