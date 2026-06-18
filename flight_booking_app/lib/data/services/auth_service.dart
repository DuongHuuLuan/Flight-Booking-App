import 'package:dio/dio.dart';
import 'package:flight_booking_app/data/models/base_response.dart';
import 'package:flight_booking_app/data/models/forgot_password_response.dart';
import 'package:flight_booking_app/data/models/reset_password_response.dart';
import 'package:flight_booking_app/data/models/user_model.dart';
import 'package:flight_booking_app/data/models/verify_otp_response.dart';
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

  @POST("/auth/forgot-password/sms")
  Future<HttpResponse<BaseResponse<ForgotPasswordResponse>>>
  forgotPasswordWithSMS(@Body() Map<String, dynamic> body);

  @POST("/auth/forgot-password/email")
  Future<HttpResponse<BaseResponse<ForgotPasswordResponse>>>
  forgotPasswordWithEmail(@Body() Map<String, dynamic> body);

  @POST("/auth/verify-otp")
  Future<HttpResponse<BaseResponse<VerifyOtpResponse>>> verifyOtp(
    @Body() Map<String, dynamic> body,
  );

  @POST("/auth/resetPassword/sms")
  Future<HttpResponse<BaseResponse<ResetPasswordResponse>>> resetPasswordBySMS(
    @Body() Map<String, dynamic> body,
  );

  @POST("/auth/resetPassword/email")
  Future<HttpResponse<BaseResponse<ResetPasswordResponse>>>
  resetPasswordByEmail(@Body() Map<String, dynamic> body);
}
