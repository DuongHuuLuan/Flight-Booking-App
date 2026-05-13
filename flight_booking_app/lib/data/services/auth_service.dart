import 'package:dio/dio.dart';
import 'package:flight_booking_app/data/models/base_response.dart';
import 'package:flight_booking_app/data/models/user.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

@injectable
@RestApi()
abstract class AuthService {
  @factoryMethod
  factory AuthService(Dio dio) = _AuthService;

  @POST("/auth/login")
  Future<HttpResponse<BaseResponse<UserModel>>> login(
    @Body() Map<String, dynamic> request,
  );

  @POST("/auth/register")
  Future<HttpResponse<BaseResponse<UserModel>>> register(
    @Body() Map<String, dynamic> request,
  );
}
