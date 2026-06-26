import 'package:dio/dio.dart';
import 'package:flight_booking_app/data/models/base_response.dart';
import 'package:flight_booking_app/data/models/flight_detail_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'flight_service.g.dart';

@injectable
@RestApi()
abstract class FlightService {
  @factoryMethod
  factory FlightService(Dio dio) = _FlightService;

  @GET("/flights/{id}")
  Future<HttpResponse<BaseResponse<FlightDetailModel>>> getFlightDetail(
    @Path("id") String id,
  );
}
