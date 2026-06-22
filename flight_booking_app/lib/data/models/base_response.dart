import 'package:flight_booking_app/data/models/booking_model.dart';
import 'package:flight_booking_app/data/models/flight_detail_model.dart';
import 'package:flight_booking_app/data/models/flight_model.dart';
import 'package:flight_booking_app/data/models/flight_search_response.dart';
import 'package:flight_booking_app/data/models/forgot_password_response.dart';
import 'package:flight_booking_app/data/models/reset_password_response.dart';
import 'package:flight_booking_app/data/models/user_model.dart';
import 'package:flight_booking_app/data/models/verify_otp_response.dart';

class BaseResponse<T> {
  final T? data;
  final String? message;
  final int? status;
  final bool? success;

  BaseResponse({this.data, this.message, this.status, this.success});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    T? data;

    final rawData = json['data'];
    if (rawData != null) {
      if (T == dynamic || T == Object) {
        data = rawData as T;
      } else if (rawData is Map<String, dynamic>) {
        data = _parseMap<T>(rawData);
      } else if (rawData is List) {
        data = _parseList<T>(rawData);
      }
    }

    return BaseResponse<T>(
      data: data,
      message: json['message'] as String?,
      status: json['status'] as int?,
      success: json['success'] as bool?,
    );
  }

  static T? _parseMap<T>(Map<String, dynamic> map) {
    if (T == UserModel) return UserModel.fromJson(map) as T;
    if (T == ForgotPasswordResponse) {
      return ForgotPasswordResponse.fromJson(map) as T;
    }
    if (T == VerifyOtpResponse) return VerifyOtpResponse.fromJson(map) as T;
    if (T == ResetPasswordResponse) {
      return ResetPasswordResponse.fromJson(map) as T;
    }
    if (T == FlightSearchResponse) {
      return FlightSearchResponse.fromJson(map) as T;
    }
    if (T == FlightDetailModel) return FlightDetailModel.fromJson(map) as T;
    if (T == BookingModel) return BookingModel.fromJson(map) as T;
    return map as T?;
  }

  static T? _parseList<T>(List list) {
    if (T == List<FlightModel>) {
      return list
              .map((e) => FlightModel.fromJson(e as Map<String, dynamic>))
              .toList()
          as T;
    }
    return list as T?;
  }
}
