class BookingEntity {
  final String id;
  final String flightId;
  final String cabinClass;
  final double totalPrice;
  final String status;
  final DateTime createdAt;

  BookingEntity({
    required this.id,
    required this.flightId,
    required this.cabinClass,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
});
}