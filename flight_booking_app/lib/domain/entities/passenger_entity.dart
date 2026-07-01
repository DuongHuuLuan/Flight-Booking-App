import 'package:equatable/equatable.dart';
import 'package:flight_booking_app/domain/enums/age_group.dart';

class PassengerEntity extends Equatable {
  final String id;
  final String bookingId;
  final String name;
  final String mobilePhone;
  final DateTime dateOfBirth;
  final String passportNumber;
  final String nationality;
  final DateTime? createdAt;
  final String? seatLabel;
  final AgeGroup? ageGroup;
  final String? address;
  final String? email;
  final String? idNumber;
  final String? baggageLevel;
  final String? baggageName;

  const PassengerEntity({
    required this.id,
    required this.bookingId,
    required this.name,
    required this.mobilePhone,
    required this.dateOfBirth,
    required this.passportNumber,
    required this.nationality,
    this.createdAt,
    this.seatLabel,
    this.ageGroup,
    this.address,
    this.email,
    this.idNumber,
    this.baggageLevel,
    this.baggageName,
  });

  @override
  List<Object?> get props => [
    id,
    bookingId,
    name,
    mobilePhone,
    dateOfBirth,
    passportNumber,
    nationality,
    seatLabel,
    ageGroup,
    address,
    email,
    idNumber,
    baggageLevel,
    baggageName,
  ];
}
