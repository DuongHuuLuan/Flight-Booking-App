import 'package:flight_booking_app/domain/Entities/location.dart';

class LocationMapper {
  static Location fromJson(Map<String, dynamic> json) {
    return Location(
      countries: List<String>.from(json['countries']),
      citiesByCountry: Map<String, List<String>>.from(
        json['citiesByCountry'].map(
          (key, value) => MapEntry(key, List<String>.from(value)),
        ),
      ),
    );
  }

  static Map<String, dynamic> toJson(Location model) {
    return {
      'countries': model.countries,
      'citiesByCountry': model.citiesByCountry,
    };
  }
}
