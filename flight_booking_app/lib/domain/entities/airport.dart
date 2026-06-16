class AirportEntity {
  final String code;
  final String name;
  final String city;
  final String country;

  AirportEntity({
    required this.code,
    required this.name,
    required this.city,
    required this.country,
  });

  AirportEntity copyWith({
    String? code,
    String? name,
    String? city,
    String? country,
  }) {
    return AirportEntity(
      code: code ?? this.code,
      name: name ?? this.name,
      city: city ?? this.city,
      country: country ?? this.country,
    );
  }
}
