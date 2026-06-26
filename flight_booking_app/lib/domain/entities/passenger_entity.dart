class PassengerEntity {
  final String id;
  final String bookingId;
  final String name;
  final String mobilePhone;
  final DateTime dateOfBirth;
  final String passportNumber;
  final String nationality;
  final DateTime? createdAt;

  const PassengerEntity({
    required this.id,
    required this.bookingId,
    required this.name,
    required this.mobilePhone,
    required this.dateOfBirth,
    required this.passportNumber,
    required this.nationality,
    this.createdAt,
  });
}
