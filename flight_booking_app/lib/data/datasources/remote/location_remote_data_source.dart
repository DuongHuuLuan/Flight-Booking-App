import 'package:flight_booking_app/data/services/location_service.dart';

class LocationRemoteDataSource {
  final LocationService _locationService;
  final bool userMock;

  LocationRemoteDataSource(this._locationService, {this.userMock = true});

  static const Map<String, dynamic> _mockData = {
    "countries": ["Vietnam", "United States", "Japan", "China"],
    "citiesByCountry": {
      "Vietnam": ["Ho Chi Minh", "Hanoi", "Da Nang"],
      "United States": ["New York", "Los Angeles", "Chicago"],
      "Japan": ["Tokyo", "Osaka", "Kyoto"],
      "China": ["Beijing", "Shanghai", "Guangzhou"],
    },
  };

  Future<List<String>> getCountries() async {
    if (userMock) {
      return List<String>.from(_mockData["countries"]);
    }

    final response = await _locationService.getCountries();
    return List<String>.from(response.data.data["countries"]);
  }

  Future<List<String>> getCitiesForCountry(String countryId) async {
    if (userMock) {
      return List<String>.from(_mockData["citiesByCountry"][countryId] ?? []);
    }

    final response = await _locationService.getCitiesForCountry(countryId);

    return List<String>.from(response.data.data["cities"] ?? []);
  }
}
