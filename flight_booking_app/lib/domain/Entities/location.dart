class Location {
  final List<String> countries;
  final Map<String, List<String>> citiesByCountry;

  Location({required this.countries, required this.citiesByCountry});

  List<String> getCitiesForCountry(String country) {
    return citiesByCountry[country] ?? [];
  }

  Location copyWith({
    List<String>? countries,
    Map<String, List<String>>? citiesByCountry,
  }) {
    return Location(
      countries: countries ?? this.countries,
      citiesByCountry: citiesByCountry ?? this.citiesByCountry,
    );
  }
}
