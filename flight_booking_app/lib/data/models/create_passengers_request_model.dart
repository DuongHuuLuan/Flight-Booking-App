import 'package:json_annotation/json_annotation.dart';

part 'create_passengers_request_model.g.dart';

@JsonSerializable()
class PassengerDataModel {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'mobile_phone')
  final String mobilePhone;

  @JsonKey(name: 'date_of_birth')
  final DateTime dateOfBirth;

  @JsonKey(name: 'passport_number')
  final String passportNumber;

  @JsonKey(name: 'nationality')
  final String nationality;

  const PassengerDataModel({
    required this.name,
    required this.mobilePhone,
    required this.dateOfBirth,
    required this.passportNumber,
    required this.nationality,
  });

  factory PassengerDataModel.fromJson(Map<String, dynamic> json) =>
      _$PassengerDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$PassengerDataModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreatePassengersRequestModel {
  @JsonKey(name: 'passengers')
  final List<PassengerDataModel> passengers;

  const CreatePassengersRequestModel({required this.passengers});

  Map<String, dynamic> toJson() => _$CreatePassengersRequestModelToJson(this);
}
