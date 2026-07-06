import 'package:json_annotation/json_annotation.dart';

part 'service_model.g.dart';

@JsonSerializable()
class ServiceModel {
  @JsonKey(name: "id")
  final String serviceId;
  final String type;
  final String name;
  final double price;
  final int maxPerPassenger;
  @JsonKey(name: "description")
  final String? description;

  const ServiceModel({
    required this.serviceId,
    required this.type,
    required this.name,
    required this.price,
    required this.maxPerPassenger,
    this.description,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);
}
