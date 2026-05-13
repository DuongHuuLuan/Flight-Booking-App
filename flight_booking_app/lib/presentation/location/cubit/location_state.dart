import 'package:equatable/equatable.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationDataLoaded extends LocationState {
  final List<String> countries;
  final List<String> cities;
  const LocationDataLoaded(this.countries, this.cities);

  @override
  List<Object?> get props => [countries, cities];
}

class CountriesLoaded extends LocationState {
  final List<String> countries;
  const CountriesLoaded(this.countries);

  @override
  List<Object?> get props => [countries];
}

class CitiesLoaded extends LocationState {
  final List<String> cities;
  const CitiesLoaded(this.cities);

  @override
  List<Object?> get props => [cities];
}

class LocationFailed extends LocationState {
  final String message;
  const LocationFailed(this.message);

  @override
  List<Object?> get props => [message];
}
