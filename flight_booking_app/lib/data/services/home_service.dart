import 'package:dio/dio.dart';
import 'package:flight_booking_app/data/models/base_response.dart';
import 'package:flight_booking_app/data/models/flight_model.dart';
import 'package:flight_booking_app/data/models/flight_search_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'home_service.g.dart';

@injectable
@RestApi()
abstract class HomeService {
  @factoryMethod
  factory HomeService(Dio dio) = _HomeService;

  @GET("/home/popular")
  Future<HttpResponse<BaseResponse<List<FlightModel>>>> getPopularFlights();

  @POST("/home/search")
  Future<HttpResponse<BaseResponse<FlightSearchResponse>>> searchFlights(
    @Body() Map<String, dynamic> params,
  );
}
