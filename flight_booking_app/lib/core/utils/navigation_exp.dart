import 'package:flight_booking_app/presentation/auth/forgot_password/forgot_password_screen.dart';
import 'package:flight_booking_app/presentation/auth/forgot_password/otp_verification_screen.dart';
import 'package:flight_booking_app/presentation/auth/forgot_password/reset_password_screen.dart';
import 'package:flight_booking_app/presentation/auth/view/login_screen.dart';
import 'package:flight_booking_app/presentation/auth/view/register_page.dart';
import 'package:flight_booking_app/presentation/home/view/home_screen.dart';
import 'package:flight_booking_app/presentation/onboarding/view/onboarding_screen.dart';
import 'package:flight_booking_app/presentation/search/search_screen.dart';
import 'package:flight_booking_app/presentation/select_flight/view/select_flight_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

extension AppNavigation on BuildContext {
  void goToOnboarding() => push(OnboardingScreen.routerName);
  void goToLogin() => push(LoginScreen.routerName);
  void goToRegister() => push(RegisterPage.routerName);
  void goToHome() => push(HomePage.routerName);
  void goToForgotPassword() => push(ForgotPasswordScreen.routerName);
  void goToOtpVerification() => push(OtpVerificationScreen.routerName);
  void goToResetPassword() => push(ResetPasswordScreen.routerName);
  void goToSearch() => push(SearchScreen.routerName);
  void goToSelectFlight([Object? extra]) =>
      push(SelectFlightScreen.routerName, extra: extra);
}
