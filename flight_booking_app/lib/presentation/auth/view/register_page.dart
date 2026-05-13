import 'package:flight_booking_app/domain/Entities/user.dart';
import 'package:flight_booking_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:flight_booking_app/presentation/auth/cubit/auth_state.dart';
import 'package:flight_booking_app/presentation/auth/view/widgets/form_register.dart';
import 'package:flight_booking_app/presentation/auth/view/widgets/logo_widget.dart';
import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/presentation/location/cubit/location_cubit.dart';
import 'package:flight_booking_app/presentation/location/cubit/location_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
    nameController.addListener(() => setState(() {}));
    emailController.addListener(() => setState(() {}));
    phoneController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
    confirmPasswordController.addListener(() => setState(() {}));
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

      context.read<AuthCubit>().register(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthFailed) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              }

              if (state is AuthAuthenticated) {
                context.go(""); // chuyển vào home page
              }
            },
          ),

          BlocListener<LocationCubit, LocationState>(
            listener: (context, state) {
              if (state is LocationFailed) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
        ],
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LogoWidget(),
                  const SizedBox(height: 40),

                  Text(
                    "Let's get you Login!",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    "Enter your information below",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: AppColor.grey),
                  ),
                  const SizedBox(height: 35),

                  BlocBuilder<LocationCubit, LocationState>(
                    builder: (context, state) {
                      final countries = state is LocationDataLoaded
                          ? state.countries
                          : <String>[];
                      final cities = state is LocationDataLoaded
                          ? state.cities
                          : <String>[];

                      return RegisterForm(
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
                            await context.read<LocationCubit>().loadCities(
                              value,
                            );
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
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            (emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty &&
                                nameController.text.isNotEmpty &&
                                phoneController.text.isNotEmpty &&
                                selectedCountry != null &&
                                selectedCity != null)
                            ? AppColor.primary
                            : AppColor.greyLight,
                        foregroundColor:
                            (emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty &&
                                nameController.text.isNotEmpty &&
                                phoneController.text.isNotEmpty &&
                                selectedCountry != null &&
                                selectedCity != null)
                            ? AppColor.white
                            : AppColor.greyDark,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (passwordController.text !=
                              confirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Passwords do not match"),
                              ),
                            );
                            return;
                          }

                          _register();
                        }
                      },
                      child: Text(
                        "Register",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already a member?"),
                      TextButton(
                        onPressed: () {
                          context.go("/login");
                        },
                        child: Text(
                          "Login",
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
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
          ),
        ),
      ),
    );
  }
}
