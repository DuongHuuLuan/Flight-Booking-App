import 'package:dio/dio.dart';
import 'package:flight_booking_app/data/models/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'location_service.g.dart';

@injectable
@RestApi()
abstract class LocationService {
  @factoryMethod
  factory LocationService(Dio dio) = _LocationService;

  @GET("/location/countries")
  Future<HttpResponse<BaseResponse<dynamic>>> getCountries();

  @GET("/location/cities")
  Future<HttpResponse<BaseResponse<dynamic>>> getCitiesForCountry(
    @Query("countryId") String countrId,
  );
}
