import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/navigation_exp.dart';
import 'package:flight_booking_app/core/widgets/app_background_image.dart';
import 'package:flight_booking_app/core/widgets/app_loading_overlay.dart';
import 'package:flight_booking_app/core/widgets/submit_button.dart';
import 'package:flight_booking_app/domain/entities/user_entity.dart';
import 'package:flight_booking_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:flight_booking_app/presentation/auth/cubit/auth_state.dart';
import 'package:flight_booking_app/presentation/auth/view/widgets/auth_form.dart';
import 'package:flight_booking_app/presentation/auth/view/widgets/logo_widget.dart';
import 'package:flight_booking_app/presentation/location/cubit/location_cubit.dart';
import 'package:flight_booking_app/presentation/location/cubit/location_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  static String get routerName => '/register';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final LocationCubit _locationCubit;
  late final AuthCubit _authCubit;

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? selectedCountry;
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    _locationCubit = context.read<LocationCubit>();
    _authCubit = context.read<AuthCubit>();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
        return;
      }

      final user = UserEntity(
        id: DateTime.now().microsecondsSinceEpoch,
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        country: selectedCountry ?? '',
        city: selectedCity ?? '',
        password: passwordController.text.trim(),
      );

      _authCubit.register(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, AuthState>(
            listenWhen: (previous, current) {
              return previous.status != current.status ||
                  previous.errorMessage != current.errorMessage;
            },
            listener: (context, state) {
              if (state.status == AuthStatus.loading) {
                context.showLoading("Creating account...");
              }
              if (state.status == AuthStatus.failed ||
                  state.status == AuthStatus.authAuthenticated) {
                context.hideLoading();
              }
              if (state.status == AuthStatus.failed &&
                  state.errorMessage != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
              }

              if (state.status == AuthStatus.authAuthenticated) {
                context.goToHome();
              }
            },
          ),

          BlocListener<LocationCubit, LocationState>(
            listener: (context, state) {
              if (state.status == LocationStatus.loading) {
                context.showLoading("Loading locations...");
              }

              if (state.status == LocationStatus.dataLoaded ||
                  state.status == LocationStatus.failure) {
                context.hideLoading();
              }

              if (state.status == LocationStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage ?? "")),
                );
              }
            },
          ),
        ],
        child: Stack(
          children: [
            AppBackgroundImage(imageUrl: "assets/images/splash_screen.png"),
            SingleChildScrollView(
              padding: const EdgeInsets.all(25),
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

                  BlocBuilder<LocationCubit, LocationState>(
                    builder: (context, state) {
                      final countries =
                          state.status == LocationStatus.dataLoaded
                          ? state.countries
                          : <String>[];
                      final cities = state.status == LocationStatus.dataLoaded
                          ? state.cities
                          : <String>[];
                      return AuthForm(
                        formKey: _formKey,
                        nameController: nameController,
                        emailController: emailController,
                        phoneController: phoneController,
                        selectedCountry: selectedCountry,
                        selectedCity: selectedCity,
                        countries: countries,
                        availableCities: cities,
                        onCountryChanged: (String? value) async {
                          setState(() {
                            selectedCountry = value;
                            selectedCity = null;
                          });
                          if (value != null) {
                            await _locationCubit.loadCities(value);
                          }
                        },
                        onCityChanged: (String? value) {
                          setState(() {
                            selectedCity = value;
                          });
                        },
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  SubmitButton(
                    controllers: [
                      nameController,
                      emailController,
                      phoneController,
                      passwordController,
                      confirmPasswordController,
                    ],
                    onPressed: () => _register(),
                    label: "Register",
                  ),

                  const SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already a member?",
                        style: AppTextStyles.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          context.goToLogin();
                        },
                        child: Text(
                          "Login",
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
        ),
      ),
    );
  }
}
