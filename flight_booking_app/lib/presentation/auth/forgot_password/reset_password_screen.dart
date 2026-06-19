import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/navigation_exp.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/widgets/app_elevated_button.dart';
import 'package:flight_booking_app/core/widgets/app_loading_overlay.dart';
import 'package:flight_booking_app/core/widgets/app_password_text_form_field.dart';
import 'package:flight_booking_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:flight_booking_app/presentation/auth/cubit/auth_state.dart';
import 'package:flight_booking_app/presentation/auth/view/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  static String get routerName => '/reset-password';
  const ResetPasswordScreen({super.key});
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late final AuthCubit _authCubit;

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubit>();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _save() {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }
    if (_passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password must be at least 6 characters")),
      );
      return;
    }
    _authCubit.resetPassword(
      newPassword: _passwordController.text,
      phone: "(808) 555-0111",
    );
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
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == AuthStatus.resetPasswordLoading) {
            context.showLoading("");
          }
          if (state.status == AuthStatus.resetPasswordSuccess ||
              state.status == AuthStatus.resetPasswordFailure) {
            context.hideLoading();
          }
          if (state.status == AuthStatus.resetPasswordFailure &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColor.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == AuthStatus.resetPasswordSuccess) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: FittedBox(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: const LogoWidget(
                        imagePath: "assets/images/oke.png",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  "Password Update\nSuccessfully",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading1,
                ),
                const SizedBox(height: 12),
                Text(
                  "Your password has been\nupdated successfully",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyLarge.copyWith(color: AppColor.grey),
                ),
                const SizedBox(height: 50),
                AppElevatedButton(
                  label: "Back to Login",
                  onPressed: () => context.goToLogin(),
                ),
              ],
            ).paddingAll(20);
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Enter New Password", style: AppTextStyles.heading2),
                const SizedBox(height: 8),
                Text(
                  "Please enter your new password",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColor.greyDark,
                    fontWeight: FontWeight.w300,
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
                AppPasswordTextFormField(
                  controller: _passwordController,
                  labelText: "Password",
                  hintText: "Enter password",
                ),
                const SizedBox(height: 20),
                AppPasswordTextFormField(
                  controller: _confirmPasswordController,
                  labelText: "Confirm Password",
                  hintText: "Confirm password",
                ),
                const SizedBox(height: 40),
                AppElevatedButton(label: "Save", onPressed: _save),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
