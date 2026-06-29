import 'package:json_annotation/json_annotation.dart';

part 'passenger_model.g.dart';

@JsonSerializable()
class PassengerModel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'bookingId')
  final String bookingId;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'mobilePhone')
  final String mobilePhone;
  @JsonKey(name: 'dateOfBirth')
  final DateTime dateOfBirth;
  @JsonKey(name: 'passportNumber')
  final String passportNumber;
  @JsonKey(name: 'nationality')
  final String nationality;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'seatLabel')
  final String? seatLabel;
  @JsonKey(name: 'ageGroup')
  final String? ageGroup;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'idNumber')
  final String? idNumber;
  @JsonKey(name: 'baggageLevel')
  final String? baggageLevel;

  const PassengerModel({
    required this.id,
    required this.bookingId,
    required this.name,
    required this.mobilePhone,
    required this.dateOfBirth,
    required this.passportNumber,
    required this.nationality,
    this.createdAt,
    this.seatLabel,
    this.ageGroup,
    this.address,
    this.email,
    this.idNumber,
    this.baggageLevel,
  });

  factory PassengerModel.fromJson(Map<String, dynamic> json) =>
      _$PassengerModelFromJson(json);

  Map<String, dynamic> toJson() => _$PassengerModelToJson(this);
}
