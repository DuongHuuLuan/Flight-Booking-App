import 'package:json_annotation/json_annotation.dart';

part 'seat_model.g.dart';

@JsonSerializable()
class SeatModel {
  final String seatLabel;
  final String cabinClass;
  final int rowNumber;
  final int position;
  final String status;
  final String? zoneId;
  final String? zoneName;
  final double? zonePrice;

  SeatModel({
    required this.seatLabel,
    required this.cabinClass,
    required this.rowNumber,
    required this.position,
    required this.status,
    this.zoneId,
    this.zoneName,
    this.zonePrice,
  });

  factory SeatModel.fromJson(Map<String, dynamic> json) =>
      _$SeatModelFromJson(json);
  Map<String, dynamic> toJson() => _$SeatModelToJson(this);
}
