enum TripType {
  oneWay,
  roundTrip,
  multiCity;

  String toJson() => name;
  static TripType fromJson(String json) =>
      TripType.values.firstWhere((e) => e.name == json);
}
