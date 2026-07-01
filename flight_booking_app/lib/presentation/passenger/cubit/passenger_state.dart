import 'package:flight_booking_app/domain/entities/passenger_entity.dart';
import 'package:flight_booking_app/domain/entities/seat/service_entity.dart';
import 'package:flight_booking_app/domain/enums/age_group.dart';

class PassengerFormData {
  final String seatLabel;
  final AgeGroup ageGroup;
  final String name;
  final String mobilePhone;
  final DateTime? dateOfBirth;
  final String passportNumber;
  final String nationality;
  final String address;
  final String email;
  final String idNumber;
  final String baggageLevel;

  const PassengerFormData({
    this.seatLabel = "",
    this.ageGroup = AgeGroup.adult,
    this.name = "",
    this.mobilePhone = "",
    this.dateOfBirth,
    this.passportNumber = "",
    this.nationality = "",
    this.address = "",
    this.email = "",
    this.idNumber = "",
    this.baggageLevel = "",
  });

  PassengerFormData copyWithField(String field, dynamic value) {
    return switch (field) {
      'seatLabel' => PassengerFormData(
        seatLabel: value as String,
        ageGroup: ageGroup,
        name: name,
        mobilePhone: mobilePhone,
        dateOfBirth: dateOfBirth,
        passportNumber: passportNumber,
        nationality: nationality,
        address: address,
        email: email,
        idNumber: idNumber,
        baggageLevel: baggageLevel,
      ),
      'ageGroup' => PassengerFormData(
        seatLabel: seatLabel,
        ageGroup: value as AgeGroup,
        name: name,
        mobilePhone: mobilePhone,
        dateOfBirth: dateOfBirth,
        passportNumber: passportNumber,
        nationality: nationality,
        address: address,
        email: email,
        idNumber: idNumber,
        baggageLevel: baggageLevel,
      ),
      'name' => PassengerFormData(
        seatLabel: seatLabel,
        ageGroup: ageGroup,
        name: value as String,
        mobilePhone: mobilePhone,
        dateOfBirth: dateOfBirth,
        passportNumber: passportNumber,
        nationality: nationality,
        address: address,
        email: email,
        idNumber: idNumber,
        baggageLevel: baggageLevel,
      ),
      'mobilePhone' => PassengerFormData(
        seatLabel: seatLabel,
        ageGroup: ageGroup,
        name: name,
        mobilePhone: value as String,
        dateOfBirth: dateOfBirth,
        passportNumber: passportNumber,
        nationality: nationality,
        address: address,
        email: email,
        idNumber: idNumber,
        baggageLevel: baggageLevel,
      ),
      'dateOfBirth' => PassengerFormData(
        seatLabel: seatLabel,
        ageGroup: ageGroup,
        name: name,
        mobilePhone: mobilePhone,
        dateOfBirth: value as DateTime?,
        passportNumber: passportNumber,
        nationality: nationality,
        address: address,
        email: email,
        idNumber: idNumber,
        baggageLevel: baggageLevel,
      ),
      'passportNumber' => PassengerFormData(
        seatLabel: seatLabel,
        ageGroup: ageGroup,
        name: name,
        mobilePhone: mobilePhone,
        dateOfBirth: dateOfBirth,
        passportNumber: value as String,
        nationality: nationality,
        address: address,
        email: email,
        idNumber: idNumber,
        baggageLevel: baggageLevel,
      ),
      'nationality' => PassengerFormData(
        seatLabel: seatLabel,
        ageGroup: ageGroup,
        name: name,
        mobilePhone: mobilePhone,
        dateOfBirth: dateOfBirth,
        passportNumber: passportNumber,
        nationality: value as String,
        address: address,
        email: email,
        idNumber: idNumber,
        baggageLevel: baggageLevel,
      ),
      'address' => PassengerFormData(
        seatLabel: seatLabel,
        ageGroup: ageGroup,
        name: name,
        mobilePhone: mobilePhone,
        dateOfBirth: dateOfBirth,
        passportNumber: passportNumber,
        nationality: nationality,
        address: value as String,
        email: email,
        idNumber: idNumber,
        baggageLevel: baggageLevel,
      ),
      'email' => PassengerFormData(
        seatLabel: seatLabel,
        ageGroup: ageGroup,
        name: name,
        mobilePhone: mobilePhone,
        dateOfBirth: dateOfBirth,
        passportNumber: passportNumber,
        nationality: nationality,
        address: address,
        email: value as String,
        idNumber: idNumber,
        baggageLevel: baggageLevel,
      ),
      'idNumber' => PassengerFormData(
        seatLabel: seatLabel,
        ageGroup: ageGroup,
        name: name,
        mobilePhone: mobilePhone,
        dateOfBirth: dateOfBirth,
        passportNumber: passportNumber,
        nationality: nationality,
        address: address,
        email: email,
        idNumber: value as String,
        baggageLevel: baggageLevel,
      ),
      'baggageLevel' => PassengerFormData(
        seatLabel: seatLabel,
        ageGroup: ageGroup,
        name: name,
        mobilePhone: mobilePhone,
        dateOfBirth: dateOfBirth,
        passportNumber: passportNumber,
        nationality: nationality,
        address: address,
        email: email,
        idNumber: idNumber,
        baggageLevel: value as String,
      ),
      _ => this,
    };
  }

  PassengerEntity toEntity({required String id, required String bookingId}) {
    return PassengerEntity(
      id: id,
      bookingId: bookingId,
      name: name,
      mobilePhone: mobilePhone,
      dateOfBirth: dateOfBirth ?? DateTime.now(),
      passportNumber: passportNumber,
      nationality: nationality,
      seatLabel: seatLabel,
      ageGroup: ageGroup,
      address: address.isEmpty ? null : address,
      email: email.isEmpty ? null : email,
      idNumber: idNumber.isEmpty ? null : idNumber,
      baggageLevel: baggageLevel.isEmpty ? null : baggageLevel,
    );
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'mobile_phone': mobilePhone,
    'date_of_birth': dateOfBirth?.toIso8601String(),
    'passport_number': passportNumber,
    'nationality': nationality,
    'seat_label': seatLabel,
    'age_group': ageGroup.name,
    'address': address,
    'email': email,
    'id_number': idNumber,
    'baggage_level': baggageLevel,
  };
}

class PassengerState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final List<PassengerEntity>? passengers;
  final List<PassengerFormData> forms;
  final List<AgeGroup> ageGroups;
  final List<ServiceEntity> baggageOptions;

  const PassengerState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    this.passengers,
    this.forms = const [],
    this.ageGroups = const [],
    this.baggageOptions = const [],
  });

  PassengerState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    List<PassengerEntity>? passengers,
    List<PassengerFormData>? forms,
    List<AgeGroup>? ageGroups,
    List<ServiceEntity>? baggageOptions,
  }) {
    return PassengerState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      passengers: passengers ?? this.passengers,
      forms: forms ?? this.forms,
      ageGroups: ageGroups ?? this.ageGroups,
      baggageOptions: baggageOptions ?? this.baggageOptions,
    );
  }
}
