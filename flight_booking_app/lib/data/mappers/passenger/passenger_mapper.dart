import 'package:flight_booking_app/data/models/passenger/create_passengers_request_model.dart';
import 'package:flight_booking_app/data/models/passenger/passenger_model.dart';
import 'package:flight_booking_app/domain/entities/passenger_entity.dart';
import 'package:flight_booking_app/domain/enums/age_group.dart';

class PassengerMapper {
  static PassengerEntity toEntity(PassengerModel model) {
    return PassengerEntity(
      id: model.id,
      bookingId: model.bookingId,
      name: model.name,
      mobilePhone: model.mobilePhone,
      dateOfBirth: model.dateOfBirth,
      passportNumber: model.passportNumber,
      nationality: model.nationality,
      createdAt: model.createdAt,
      seatLabel: model.seatLabel,
      ageGroup: model.ageGroup != null
          ? AgeGroup.values.firstWhere(
              (element) => element.name == model.ageGroup,
            )
          : null,
      address: model.address,
      email: model.email,
      idNumber: model.idNumber,
      baggageLevel: model.baggageLevel,
      baggageName: model.baggageName,
    );
  }

  static PassengerDataModel toCreateModel(PassengerEntity entity) {
    return PassengerDataModel(
      name: entity.name,
      mobilePhone: entity.mobilePhone,
      dateOfBirth: entity.dateOfBirth,
      passportNumber: entity.passportNumber,
      nationality: entity.nationality,
      seatLabel: entity.seatLabel,
      ageGroup: entity.ageGroup?.name,
      address: entity.address,
      email: entity.email,
      idNumber: entity.idNumber,
      baggageLevel: entity.baggageLevel,
    );
  }
}
