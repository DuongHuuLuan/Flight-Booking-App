import 'dart:async';

import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/error_snack_bar.dart';
import 'package:flight_booking_app/core/utils/navigation_exp.dart';
import 'package:flight_booking_app/core/widgets/app_elevated_button.dart';
import 'package:flight_booking_app/core/widgets/app_loading_overlay.dart';
import 'package:flight_booking_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:flight_booking_app/presentation/auth/bloc/auth_event.dart';
import 'package:flight_booking_app/presentation/auth/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/otp_input_field.dart';

class OtpVerificationScreen extends StatefulWidget {
  static String get routerName => '/otp-verification';
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late final AuthBloc _authBloc;
  String otp = '';
  Timer? _timer;
  int _remainingSeconds = 60;

  @override
  void initState() {
    super.initState();
    _authBloc = context.read<AuthBloc>();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _remainingSeconds = 60);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.goToForgotPassword();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.successMessage != null || state.errorMessage != null) {
            context.hideLoading();
          }
          if (state.successMessage != null) {
            context.goToResetPassword();
          } else if (state.errorMessage != null) {
            context.showError(state.errorMessage!);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Enter OTP Code", style: AppTextStyles.heading2),
                const SizedBox(height: 8),
                Text(
                  "OTP code has been sent to your contact",
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w300,
                    color: AppColor.greyDark,
                  ),
                ),
                const SizedBox(height: 40),

                OtpInputField(
                  onCompleted: (otp) {
                    setState(() => otp = otp);
                  },
                ),

                const SizedBox(height: 20),
                Center(
                  child: _remainingSeconds > 0
                      ? Text(
                          "Resend code 00:${_remainingSeconds.toString().padLeft(2, '0')}s",
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColor.greyDark,
                          ),
                        )
                      : GestureDetector(
                          onTap: _startTimer,
                          child: Text(
                            "Resend code",
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),

                const SizedBox(height: 40),
                AppElevatedButton(
                  label: "Verify",
                  onPressed: otp.length == 4
                      ? () {
                          _authBloc.add(VerifyOtpEvent(otp: otp));
                          context.showLoading("Verifying OTP...");
                        }
                      : null,
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
