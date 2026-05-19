import 'dart:convert';

import 'package:flight_booking_app/data/mappers/flight_mapper.dart';
import 'package:flight_booking_app/data/models/flight_model.dart';
import 'package:flight_booking_app/data/services/home_service.dart';
import 'package:flight_booking_app/domain/Entities/flight.dart';
import 'package:flight_booking_app/domain/Entities/flight_search_params.dart';

class HomeRemoteDataSource {
  final HomeService _homeService;
  final bool userMock;
  HomeRemoteDataSource(this._homeService, {this.userMock = true});
  static const String _mockFlightsJson = '''
[
  {
    "id": "FL001",
    "airline": {
      "id": "VN",
      "name": "Vietnam Airlines",
      "logoUrl": ""
    },
    "flightNumber": "VN123",
    "departureAirport": {
      "code": "SGN",
      "name": "Tan Son Nhat",
      "city": "Ho Chi Minh",
      "country": "Vietnam"
    },
    "arrivalAirport": {
      "code": "HAN",
      "name": "Noi Bai",
      "city": "Hanoi",
      "country": "Vietnam"
    },
    "departureTime": "2026-06-01T08:00:00",
    "arrivalTime": "2026-06-01T10:00:00",
    "duration": 120,
    "price": 1500000,
    "stops": 0,
    "cabinClass": "economy"
  },
  {
    "id": "FL002",
    "airline": {
      "id": "VJ",
      "name": "VietJet Air",
      "logoUrl": ""
    },
    "flightNumber": "VJ456",
    "departureAirport": {
      "code": "SGN",
      "name": "Tan Son Nhat",
      "city": "Ho Chi Minh",
      "country": "Vietnam"
    },
    "arrivalAirport": {
      "code": "DAD",
      "name": "Da Nang",
      "city": "Da Nang",
      "country": "Vietnam"
    },
    "departureTime": "2026-06-01T14:30:00",
    "arrivalTime": "2026-06-01T15:45:00",
    "duration": 75,
    "price": 800000,
    "stops": 0,
    "cabinClass": "economy"
  },
  {
    "id": "FL003",
    "airline": {
      "id": "QH",
      "name": "Bamboo Airways",
      "logoUrl": ""
    },
    "flightNumber": "QH789",
    "departureAirport": {
      "code": "HAN",
      "name": "Noi Bai",
      "city": "Hanoi",
      "country": "Vietnam"
    },
    "arrivalAirport": {
      "code": "SGN",
      "name": "Tan Son Nhat",
      "city": "Ho Chi Minh",
      "country": "Vietnam"
    },
    "departureTime": "2026-06-02T06:00:00",
    "arrivalTime": "2026-06-02T08:15:00",
    "duration": 135,
    "price": 1200000,
    "stops": 0,
    "cabinClass": "business"
  },
  {
    "id": "FL004",
    "airline": {
      "id": "VN",
      "name": "Vietnam Airlines",
      "logoUrl": ""
    },
    "flightNumber": "VN888",
    "departureAirport": {
      "code": "SGN",
      "name": "Tan Son Nhat",
      "city": "Ho Chi Minh",
      "country": "Vietnam"
    },
    "arrivalAirport": {
      "code": "HAN",
      "name": "Noi Bai",
      "city": "Hanoi",
      "country": "Vietnam"
    },
    "departureTime": "2026-06-01T19:00:00",
    "arrivalTime": "2026-06-01T21:00:00",
    "duration": 120,
    "price": 2500000,
    "stops": 0,
    "cabinClass": "business"
  },
  {
    "id": "FL005",
    "airline": {
      "id": "VJ",
      "name": "VietJet Air",
      "logoUrl": ""
    },
    "flightNumber": "VJ222",
    "departureAirport": {
      "code": "DAD",
      "name": "Da Nang",
      "city": "Da Nang",
      "country": "Vietnam"
    },
    "arrivalAirport": {
      "code": "SGN",
      "name": "Tan Son Nhat",
      "city": "Ho Chi Minh",
      "country": "Vietnam"
    },
    "departureTime": "2026-06-03T09:30:00",
    "arrivalTime": "2026-06-03T10:45:00",
    "duration": 75,
    "price": 700000,
    "stops": 0,
    "cabinClass": "economy"
  },
  {
    "id": "FL006",
    "airline": {
      "id": "VN",
      "name": "Vietnam Airlines",
      "logoUrl": ""
    },
    "flightNumber": "VN666",
    "departureAirport": {
      "code": "SGN",
      "name": "Tan Son Nhat",
      "city": "Ho Chi Minh",
      "country": "Vietnam"
    },
    "arrivalAirport": {
      "code": "HAN",
      "name": "Noi Bai",
      "city": "Hanoi",
      "country": "Vietnam"
    },
    "departureTime": "2026-06-02T06:30:00",
    "arrivalTime": "2026-06-02T08:30:00",
    "duration": 120,
    "price": 5000000,
    "stops": 0,
    "cabinClass": "first"
  },
  {
    "id": "FL007",
    "airline": {
      "id": "QH",
      "name": "Bamboo Airways",
      "logoUrl": ""
    },
    "flightNumber": "QH111",
    "departureAirport": {
      "code": "HAN",
      "name": "Noi Bai",
      "city": "Hanoi",
      "country": "Vietnam"
    },
    "arrivalAirport": {
      "code": "DAD",
      "name": "Da Nang",
      "city": "Da Nang",
      "country": "Vietnam"
    },
    "departureTime": "2026-06-04T14:00:00",
    "arrivalTime": "2026-06-04T15:15:00",
    "duration": 75,
    "price": 1800000,
    "stops": 0,
    "cabinClass": "economy"
  }
]
''';

  Future<List<FlightEntity>> getPopularFlights() async {
    if (userMock) {
      final List<dynamic> jsonList = jsonDecode(_mockFlightsJson);
      final List<FlightModel> models = jsonList
          .map((json) => FlightModel.fromJson(json))
          .toList();

      return models.map((model) => FlightMapper.fromModel(model)).toList();
    }
    try {
      final response = await _homeService.getPopularFlights();
      final List<FlightModel> flightModels = response.data.data!;
      return flightModels
          .map((model) => FlightMapper.fromModel(model))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<FlightEntity>> searchFlights(FlightSearchParams params) async {
    if (userMock) {
      final List<dynamic> jsonList = jsonDecode(_mockFlightsJson);
      final List<FlightModel> models = jsonList
          .map((json) => FlightModel.fromJson(json))
          .toList();

      return models
          .where(
            (flight) =>
                flight.departureAirport.code == params.origin &&
                flight.arrivalAirport.code == params.destination &&
                flight.cabinClass == params.cabinClass,
          )
          .map((model) => FlightMapper.fromModel(model))
          .toList();
    }

    try {
      final response = await _homeService.searchFlights({
        "trip_type": params.tripType.name,
        "origin": params.origin,
        "destination": params.destination,
        "departure_date": params.departureDate.toIso8601String(),
        if (params.returnDate != null)
          "return_date": params.returnDate!.toIso8601String(),
        "passengers": params.passengerCount,
        "cabin_class": params.cabinClass.name,
      });
      final flightSearchResponse = response.data.data!;
      return flightSearchResponse.flights
          .map((model) => FlightMapper.fromModel(model))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<FlightEntity>> getAllFlights() async {
    if (userMock) {
      final List<dynamic> jsonList = jsonDecode(_mockFlightsJson);
      final List<FlightModel> models = jsonList
          .map((json) => FlightModel.fromJson(json))
          .toList();

      return models.map((model) => FlightMapper.fromModel(model)).toList();
    }
    try {
      final response = await _homeService.getPopularFlights();

      final List<FlightModel> flightModels = response.data.data!;

      return flightModels
          .map((model) => FlightMapper.fromModel(model))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
