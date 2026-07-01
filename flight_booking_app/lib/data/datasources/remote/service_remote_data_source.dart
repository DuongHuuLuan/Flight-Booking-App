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
    required String flightId,
    required String zoneId,
    required AgeGroup ageGroup,
  }) async {
    try {
      final response = await _serviceService.getEligibleServices(
        flightId,
        zoneId,
        ageGroup.name,
      );
      final data = response.data.data!;

      List<ServiceEntity> parseList(String key) => (data[key] as List)
          .map(
            (e) => ServiceMapper.fromModel(
              ServiceModel.fromJson(e as Map<String, dynamic>),
            ),
          )
          .toList();

      return EligibleServiceGroup(
        meals: parseList('meals'),
        drinks: parseList('drinks'),
        baggage: parseList('baggage'),
        limits: (data['limits'] as List?)
            ?.map((e) => MapEntry(e['serviceType'] as String, e['maxQuantity'] as int))
            .fold<Map<String, int>>({}, (map, entry) {
              map[entry.key] = entry.value;
              return map;
            }) ?? <String, int>{},
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
        'passengers': passengerServices,
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
