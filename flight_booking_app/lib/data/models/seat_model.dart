import 'package:json_annotation/json_annotation.dart';

part 'seat_model.g.dart';

@JsonSerializable()
class SeatModel {
  final String seatLabel;
  final String cabinClass;
  final int rowNumber;
  final int position;
  final String status;

  SeatModel({
    required this.seatLabel,
    required this.cabinClass,
    required this.rowNumber,
    required this.position,
    required this.status,
  });

  factory SeatModel.fromJson(Map<String, dynamic> json) =>
      _$SeatModelFromJson(json);
  Map<String, dynamic> toJson() => _$SeatModelToJson(this);
}
