import 'package:equatable/equatable.dart';
import 'package:flight_booking_app/domain/Entities/flight.dart';
import 'package:flutter/material.dart';

enum StopsFilter { all, nonStop, oneStop }

enum TimeFilter { any, morning, afternoon, evening, night }

class SelectFlightState extends Equatable {
  final bool isLoading;
  final List<FlightEntity> allFlights;
  final List<FlightEntity> filteredFlights;
  final DateTime selectedDate;
  final StopsFilter stops;
  final TimeFilter departureTime;
  final TimeFilter arrivalTime;
  final RangeValues priceRange;
  final double minPrice;
  final double maxPrice;

  SelectFlightState({
    this.isLoading = true,
    this.allFlights = const [],
    this.filteredFlights = const [],
    DateTime? selectedDate,
    this.stops = StopsFilter.all,
    this.departureTime = TimeFilter.any,
    this.arrivalTime = TimeFilter.any,
    this.priceRange = const RangeValues(0, 10000),
    this.minPrice = 0,
    this.maxPrice = 10000,
  }) : selectedDate = selectedDate ?? DateTime.now();

  SelectFlightState copyWith({
    bool? isLoading,
    List<FlightEntity>? allFlights,
    List<FlightEntity>? filteredFlights,
    DateTime? selectedDate,
    StopsFilter? stops,
    TimeFilter? departureTime,
    TimeFilter? arrivalTime,
    RangeValues? priceRange,
    double? minPrice,
    double? maxPrice,
  }) {
    return SelectFlightState(
      isLoading: isLoading ?? this.isLoading,
      allFlights: allFlights ?? this.allFlights,
      filteredFlights: filteredFlights ?? this.filteredFlights,
      selectedDate: selectedDate ?? this.selectedDate,
      stops: stops ?? this.stops,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      priceRange: priceRange ?? this.priceRange,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    allFlights,
    filteredFlights,
    selectedDate,
    stops,
    departureTime,
    arrivalTime,
    priceRange,
    minPrice,
    maxPrice,
  ];
}
