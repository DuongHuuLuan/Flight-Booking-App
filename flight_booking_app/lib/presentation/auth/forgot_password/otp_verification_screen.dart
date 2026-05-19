import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/widgets/app_elevated_button.dart';
import 'package:flight_booking_app/presentation/auth/cubit/auth_state.dart';
import 'package:flight_booking_app/presentation/auth/forgot_password/forgot_password_screen.dart';
import 'package:flight_booking_app/presentation/auth/forgot_password/reset_password_screen.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flight_booking_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:go_router/go_router.dart';
import 'widgets/otp_input_field.dart';

extension OtpVerificationNavigation on BuildContext {
  void goToOtpVerification() => go('/otp-verification');
}

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late final AuthCubit _authCubit;
  String _otp = '';
  Timer? _timer;
  int _remainingSeconds = 60;

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubit>();
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
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is VerifyOtpSuccess) {
            context.goToResetPassword();
          } else if (state is VerifyOtpFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: AppColor.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is VerifyOtpLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter OTP Code",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "OTP code has been sent to your contact",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColor.greyDark,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 40),

                OtpInputField(
                  onCompleted: (otp) {
                    setState(() => _otp = otp);
                  },
                ),

                const SizedBox(height: 20),
                Center(
                  child: _remainingSeconds > 0
                      ? Text(
                          "Resend code 00:${_remainingSeconds.toString().padLeft(2, '0')}s",
                          style: TextStyle(color: AppColor.greyDark),
                        )
                      : GestureDetector(
                          onTap: _startTimer,
                          child: Text(
                            "Resend code",
                            style: TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),

                const SizedBox(height: 40),
                AppElevatedButton(
                  label: "Verify",
                  onPressed: _otp.length == 4
                      ? () => _authCubit.verifyOtpCode(otp: _otp)
                      : null,
                  isLoading: isLoading,
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
