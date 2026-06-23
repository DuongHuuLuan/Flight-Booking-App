import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/navigation_exp.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/utils/widget_pop_scope.dart';
import 'package:flight_booking_app/core/widgets/app_background_image.dart';
import 'package:flight_booking_app/core/widgets/app_loading_overlay.dart';
import 'package:flight_booking_app/core/widgets/submit_button.dart';
import 'package:flight_booking_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:flight_booking_app/presentation/auth/bloc/auth_event.dart';
import 'package:flight_booking_app/presentation/auth/bloc/auth_state.dart';
import 'package:flight_booking_app/presentation/auth/view/widgets/auth_form.dart';
import 'package:flight_booking_app/presentation/auth/view/widgets/logo_widget.dart';
import 'package:flight_booking_app/presentation/auth/view/widgets/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  static String get routerName => '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final AuthBloc _authBloc;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authBloc = context.read<AuthBloc>();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    _authBloc.add(LoginEvent(email, password));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.isLoading) {
            context.showLoading("Signing in...");
          }
          if (state.status == AuthStatus.authAuthenticated ||
              state.errorMessage != null) {
            context.hideLoading();
          }
          if (state.status == AuthStatus.authAuthenticated) {
            context.goToHome();
          }
        },
        builder: (context, state) {
          final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
          return Stack(
            children: [
              AppBackgroundImage(imageUrl: "assets/images/splash_screen.png"),
              SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 25,
                  right: 25,
                  top: 25,
                  bottom: 25 + keyboardHeight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    FittedBox(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: const LogoWidget(
                          imagePath: "assets/images/logo.png",
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text("Let's get you Login!", style: AppTextStyles.heading1),
                    const SizedBox(height: 8),
                    Text(
                      "Enter your information below",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColor.grey,
                      ),
                    ),
                    const SizedBox(height: 25),
                    const SocialLoginButtons(),
                    const SizedBox(height: 35),
                    Row(
                      children: [
                        Expanded(child: Divider(color: AppColor.greyLight)),
                        Text(
                          "Or login with",
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColor.greyDark,
                          ),
                        ).paddingHorizontal(15),
                        Expanded(child: Divider(color: AppColor.greyLight)),
                      ],
                    ),
                    const SizedBox(height: 35),
                    AuthForm(
                      formKey: _formKey,
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          context.goToForgotPassword();
                        },
                        child: Text(
                          "Forgot Password?",
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColor.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SubmitButton(
                      controllers: [emailController, passwordController],
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _login();
                        }
                      },
                      label: "Login",
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: AppTextStyles.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            context.goToRegister();
                          },
                          child: Text(
                            "Register Now",
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    ).canPop(false);
  }
}
