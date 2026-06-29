import 'package:flight_booking_app/data/models/passenger/create_passengers_request_model.dart';
import 'package:flight_booking_app/data/models/passenger/passenger_model.dart';
import 'package:flight_booking_app/data/services/passenger_service.dart';

class PassengerRemoteDataSource {
  final PassengerService _passengerService;

  PassengerRemoteDataSource(this._passengerService);

  Future<List<PassengerModel>> createPassengers(
    String bookingId,
    CreatePassengersRequestModel request,
  ) async {
    try {
      final response = await _passengerService.createPassengers(
        bookingId,
        request,
      );
      return response.data.data!;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<PassengerModel> updatePassenger({
    required String bookingId,
    required String passengerId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _passengerService.updatePassenger(
        bookingId,
        passengerId,
        data,
      );
      return response.data.data!;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
