enum CabinClass {
  economy,
  business,
  first;

  String toJson() => name;
  static CabinClass fromJson(String json) =>
      CabinClass.values.firstWhere((e) => e.name == json);
}
