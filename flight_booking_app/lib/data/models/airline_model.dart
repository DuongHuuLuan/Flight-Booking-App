import 'package:json_annotation/json_annotation.dart';
part 'airline_model.g.dart';

@JsonSerializable()
class AirlineModel {
  final String id;
  final String name;
  final String logoUrl;

  AirlineModel({required this.id, required this.name, required this.logoUrl});

  factory AirlineModel.fromJson(Map<String, dynamic> json) =>
      _$AirlineModelFromJson(json);

  Map<String, dynamic> toJson() => _$AirlineModelToJson(this);
}
