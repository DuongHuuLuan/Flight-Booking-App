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

  const PassengerModel({
    required this.id,
    required this.bookingId,
    required this.name,
    required this.mobilePhone,
    required this.dateOfBirth,
    required this.passportNumber,
    required this.nationality,
    this.createdAt,
  });

  factory PassengerModel.fromJson(Map<String, dynamic> json) =>
      _$PassengerModelFromJson(json);

  Map<String, dynamic> toJson() => _$PassengerModelToJson(this);
}
