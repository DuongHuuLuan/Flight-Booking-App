// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightSearchResponse _$FlightSearchResponseFromJson(
  Map<String, dynamic> json,
) => FlightSearchResponse(
  flights: (json['flights'] as List<dynamic>)
      .map((e) => FlightModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalCount: (json['totalCount'] as num).toInt(),
  page: (json['page'] as num).toInt(),
);

Map<String, dynamic> _$FlightSearchResponseToJson(
  FlightSearchResponse instance,
) => <String, dynamic>{
  'flights': instance.flights.map((e) => e.toJson()).toList(),
  'totalCount': instance.totalCount,
  'page': instance.page,
};
