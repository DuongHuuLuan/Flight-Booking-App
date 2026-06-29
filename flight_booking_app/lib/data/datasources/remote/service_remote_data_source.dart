import 'package:flight_booking_app/data/mappers/service/service_mapper.dart';
import 'package:flight_booking_app/data/models/service/service_model.dart';
import 'package:flight_booking_app/data/services/service_service.dart';
import 'package:flight_booking_app/domain/entities/eligible_service_group.dart';
import 'package:flight_booking_app/domain/entities/seat/service_entity.dart';
import 'package:flight_booking_app/domain/enums/age_group.dart';

class ServiceRemoteDataSource {
  final ServiceService _serviceService;

  ServiceRemoteDataSource(this._serviceService);

  Future<EligibleServiceGroup> getEligibleServices({
    required String zoneId,
    required AgeGroup ageGroup,
  }) async {
    try {
      final response = await _serviceService.getEligibleServices(
        zoneId,
        ageGroup.name,
      );
      final data = response.data.data!;

      List<ServiceEntity> _parseList(String key) => (data[key] as List)
          .map(
            (e) => ServiceMapper.fromModel(
              ServiceModel.fromJson(e as Map<String, dynamic>),
            ),
          )
          .toList();

      return EligibleServiceGroup(
        meals: _parseList('meals'),
        drinks: _parseList('drinks'),
        baggage: _parseList('baggage'),
        limits: Map<String, int>.from(data['limits'] ?? {}),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> assignServices({
    required String bookingId,
    required List<Map<String, dynamic>> passengerServices,
  }) async {
    try {
      await _serviceService.assignServices(bookingId, {
        'passenger_services': passengerServices,
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
