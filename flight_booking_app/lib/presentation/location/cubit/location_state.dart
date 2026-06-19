import 'package:equatable/equatable.dart';

enum LocationStatus { initial, loading, dataLoaded, failure }

class LocationState extends Equatable {
  final LocationStatus status;
  final List<String> countries;
  final List<String> cities;
  final String? errorMessage;

  const LocationState({
    this.status = LocationStatus.initial,
    this.countries = const [],
    this.cities = const [],
    this.errorMessage,
  });

  LocationState copyWith({
    LocationStatus? status,
    List<String>? countries,
    List<String>? cities,
    String? errorMessage,
  }) => LocationState(
    status: status ?? this.status,
    countries: countries ?? this.countries,
    cities: cities ?? this.cities,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [status, countries, cities, errorMessage];
}
