import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/widgets/app_elevated_button.dart';
import 'package:flight_booking_app/core/widgets/app_text_form_field.dart';
import 'package:flight_booking_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:flight_booking_app/presentation/auth/cubit/auth_state.dart';
import 'package:flight_booking_app/presentation/auth/forgot_password/otp_verification_screen.dart';
import 'package:flight_booking_app/presentation/auth/view/login_page.dart';
import 'package:flight_booking_app/presentation/auth/view/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

extension ForgotPasswordNavigation on BuildContext {
  void goToForgotPassword() => go('/forgot-password');
}

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final AuthCubit _authCubit;
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubit>();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _continue() {
    final phone = _phoneController.text.trim();
    final email = _emailController.text.trim();

    if (phone.isNotEmpty) {
      _authCubit.forgotPasswordWithSMS(phone);
    } else if (email.isNotEmpty) {
      _authCubit.forgotPasswordWithEmail(email);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please enter phone or email")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.goToLogin();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.forgotPasswordSuccess) {
            context.goToOtpVerification();
          } else if (state.status == AuthStatus.forgotPasswordFailure && state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          final isLoading = state.status == AuthStatus.forgotPasswordLoading;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Forgot Password",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Select which contact details should we use to your password",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w300,
                    color: AppColor.greyDark,
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: FittedBox(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: const LogoWidget(
                        imagePath: "assets/images/lock.png",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                AppTextFormField(
                  controller: _phoneController,
                  labelText: "Send OTP via SMS",
                  hintText: "Phone Number",
                  prefixIcon: Icons.phone_outlined,
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                  controller: _emailController,
                  labelText: "Send OTP via Email",
                  hintText: "Email Address",
                  prefixIcon: Icons.email_outlined,
                ),
                const SizedBox(height: 40),
                AppElevatedButton(
                  label: "Continue",
                  isLoading: isLoading,
                  onPressed: _continue,
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
