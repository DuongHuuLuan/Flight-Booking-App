import 'package:json_annotation/json_annotation.dart';

part 'create_booking_request_model.g.dart';

@JsonSerializable()
class SeatInputModel {
  @JsonKey(name: "seat_label")
  final String seatLabel;
  @JsonKey(name: "zone_id")
  final String zoneId;

  const SeatInputModel({required this.seatLabel, required this.zoneId});

  factory SeatInputModel.fromJson(Map<String, dynamic> json) =>
      _$SeatInputModelFromJson(json);
  Map<String, dynamic> toJson() => _$SeatInputModelToJson(this);
}

@JsonSerializable()
class CreateBookingRequestModel {
  @JsonKey(name: 'flight_id')
  final String flightId;
  final List<SeatInputModel> seats;

  const CreateBookingRequestModel({
    required this.flightId,
    required this.seats,
  });

  Map<String, dynamic> toJson() => _$CreateBookingRequestModelToJson(this);
}
