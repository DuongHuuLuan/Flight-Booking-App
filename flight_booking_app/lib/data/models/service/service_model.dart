import 'package:json_annotation/json_annotation.dart';
part 'service_model.g.dart';

@JsonSerializable()
class ServiceModel {
  final String serviceId;
  final String type;
  final String name;
  final double price;
  final int maxPerPassenger;

  const ServiceModel({
    required this.serviceId,
    required this.type,
    required this.name,
    required this.price,
    required this.maxPerPassenger,
});

  factory ServiceModel.fromJson(Map<String, dynamic> json) => _$ServiceModelFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);
}
