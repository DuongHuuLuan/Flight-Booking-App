import 'package:flight_booking_app/core/widgets/app_dropdown_button_form_field.dart';
import 'package:flight_booking_app/core/widgets/app_password_text_form_field.dart';
import 'package:flight_booking_app/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final String? selectedCountry;
  final String? selectedCity;
  final Function(String?) onCountryChanged;
  final Function(String?) onCityChanged;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final List<String> countries;
  final List<String> availableCities;

  const RegisterForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.selectedCountry,
    required this.selectedCity,
    required this.onCountryChanged,
    required this.onCityChanged,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.countries,
    required this.availableCities,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AppTextFormField(
            controller: nameController,
            labelText: "Name",
            hintText: "Enter Name",
            prefixIcon: Icons.person_outline,
          ),

          const SizedBox(height: 20),
          AppTextFormField(
            controller: emailController,
            labelText: "Email Address",
            hintText: "Enter Email",
            prefixIcon: Icons.email_outlined,
          ),

          const SizedBox(height: 20),
          AppTextFormField(
            controller: phoneController,
            labelText: "Mobile Number",
            hintText: "Enter Mobile Number",
            prefixIcon: Icons.phone_outlined,
          ),

          const SizedBox(height: 20),

          AppDropdownButtonFormField<String>(
            value: selectedCountry,
            labelText: "Select Country",
            prefixIcon: Icons.flag_outlined,
            items: countries.map((String country) {
              return DropdownMenuItem<String>(
                value: country,
                child: Text(country),
              );
            }).toList(),
            onChanged: onCountryChanged,
            validator: (value) => (value == null || value.isEmpty)
                ? "Select Country is required"
                : null,
          ),

          const SizedBox(height: 20),
          AppDropdownButtonFormField<String>(
            value: selectedCity,
            labelText: "Select City",
            prefixIcon: Icons.location_city_outlined,
            items: availableCities.map((String city) {
              return DropdownMenuItem(value: city, child: Text(city));
            }).toList(),
            onChanged: onCityChanged,
            validator: (value) => (value == null || value.isEmpty)
                ? " Select City is required"
                : null,
          ),

          const SizedBox(height: 20),
          AppPasswordTextFormField(
            controller: passwordController,
            labelText: "Password",
            hintText: "Enter Password",
          ),

          const SizedBox(height: 20),
          AppPasswordTextFormField(
            controller: confirmPasswordController,
            labelText: "Confirm Password",
            hintText: "Confirm Password",
          ),
        ],
      ),
    );
  }
}
