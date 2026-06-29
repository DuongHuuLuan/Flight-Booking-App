class PassengerCountState {
  final int adults;
  final int children;
  final int seniors;

  const PassengerCountState({
    this.adults = 1,
    this.children = 0,
    this.seniors = 0,
  });

  int get total => adults + children + seniors;

  PassengerCountState copyWith({
    int? adults,
    int? children,
    int? seniors,
}){
    return PassengerCountState(
      adults: adults ?? this.adults,
      children: children ?? this.children,
      seniors: seniors ?? this.seniors,
    );
  }
}
