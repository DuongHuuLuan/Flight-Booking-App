class AirlineEntity {
  final String id;
  final String name;
  final String logoUrl;

  AirlineEntity({
    required this.id,
    required this.name,
    required this.logoUrl,
  });

  AirlineEntity copyWith({
    String? id,
    String? name,
    String? logoUrl,
  }) {
    return AirlineEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      logoUrl: logoUrl ?? this.logoUrl,
    );
  }
}
