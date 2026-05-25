import 'package:flight_booking_app/data/models/flight_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flight_search_response.g.dart';

@JsonSerializable(explicitToJson: true)
class FlightSearchResponse {
  final List<FlightModel> flights;
  final int totalCount;
  final int page;

  FlightSearchResponse({
    required this.flights,
    required this.totalCount,
    required this.page,
  });

  factory FlightSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$FlightSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FlightSearchResponseToJson(this);
}
