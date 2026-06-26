import 'package:flight_booking_app/data/models/create_passengers_request_model.dart';
import 'package:flight_booking_app/data/models/passenger_model.dart';
import 'package:flight_booking_app/data/services/passenger_service.dart';

class PassengerRemoteDataSource {
  final PassengerService _passengerService;

  PassengerRemoteDataSource(this._passengerService);

  Future<List<PassengerModel>> createPassengers(
    String bookingId,
    CreatePassengersRequestModel request,
  ) async {
    try {
      final response =
          await _passengerService.createPassengers(bookingId, request);
      return response.data.data!;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
