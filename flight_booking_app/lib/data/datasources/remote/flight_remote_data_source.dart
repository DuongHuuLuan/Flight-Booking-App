import 'package:flight_booking_app/data/mappers/flight/flight_detail_mapper.dart';
import 'package:flight_booking_app/data/services/flight_service.dart';
import 'package:flight_booking_app/domain/entities/flight_detail_entity.dart';

class FlightRemoteDataSource {
  final FlightService _flightService;

  FlightRemoteDataSource(this._flightService);

  Future<FlightDetailEntity> getFlightDetail(String id) async {
    try {
      final response = await _flightService.getFlightDetail(id);
      final model = response.data.data!;
      return FlightDetailMapper.fromModel(model);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
