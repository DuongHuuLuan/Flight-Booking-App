import 'package:flight_booking_app/domain/entities/booking_detail_entity.dart';
import 'package:flight_booking_app/presentation/auth/forgot_password/forgot_password_screen.dart';
import 'package:flight_booking_app/presentation/auth/forgot_password/otp_verification_screen.dart';
import 'package:flight_booking_app/presentation/auth/forgot_password/reset_password_screen.dart';
import 'package:flight_booking_app/presentation/auth/view/login_screen.dart';
import 'package:flight_booking_app/presentation/auth/view/register_screen.dart';
import 'package:flight_booking_app/presentation/boarding_pass/view/boarding_pass_screen.dart';
import 'package:flight_booking_app/presentation/flight/flight_detail/view/flight_detail_screen.dart';
import 'package:flight_booking_app/presentation/flight/select_flight/view/select_flight_screen.dart';
import 'package:flight_booking_app/presentation/flight/select_seat/view/select_seat_screen.dart';
import 'package:flight_booking_app/presentation/home/view/home_screen.dart';
import 'package:flight_booking_app/presentation/onboarding/view/onboarding_screen.dart';
import 'package:flight_booking_app/presentation/payment_method/view/payment_method_screen.dart';
import 'package:flight_booking_app/presentation/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension AppNavigation on BuildContext {
  void goToOnboarding() => push(OnboardingScreen.routerName);
  void goToLogin() => push(LoginScreen.routerName);
  void goToRegister() => push(RegisterScreen.routerName);
  void goToHome() => push(HomePage.routerName);
  void goToForgotPassword() => push(ForgotPasswordScreen.routerName);
  void goToOtpVerification() => push(OtpVerificationScreen.routerName);
  void goToResetPassword() => push(ResetPasswordScreen.routerName);
  void goToSearch() => push(SearchScreen.routerName);

  void goToSelectFlight([Object? extra]) =>
      push(SelectFlightScreen.routerName, extra: extra);

  void goToFlightDetail(String flightId) =>
      push(FlightDetailScreen.routerName, extra: flightId);

  void goToSelectSeat({
    required String flightId,
    required String cabinClass,
    required double basePrice,
  }) => push(
    SelectSeatScreen.routerName,
    extra: {
      'flightId': flightId,
      'cabinClass': cabinClass,
      'basePrice': basePrice,
    },
  );
  void goToPaymentMethod({double? totalPrice, BookingDetailEntity? booking}) =>
      push(
        PaymentMethodScreen.routerName,
        extra: {'totalPrice': totalPrice, 'booking': booking},
      );

  void goToBoardingPass(BookingDetailEntity booking) =>
      push(BoardingPassScreen.routerName, extra: booking);
}
