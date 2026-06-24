import 'package:flight_booking_app/data/models/passenger_model.dart';
import 'package:flight_booking_app/data/models/create_passengers_request_model.dart';
import 'package:flight_booking_app/domain/entities/passenger_entity.dart';

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
    );
  }

  static PassengerDataModel toCreateModel(PassengerEntity entity) {
    return PassengerDataModel(
      name: entity.name,
      mobilePhone: entity.mobilePhone,
      dateOfBirth: entity.dateOfBirth,
      passportNumber: entity.passportNumber,
      nationality: entity.nationality,
    );
  }
}
