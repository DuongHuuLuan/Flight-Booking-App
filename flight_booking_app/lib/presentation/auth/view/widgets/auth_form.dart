import 'package:flight_booking_app/core/widgets/app_dropdown_button_form_field.dart';
import 'package:flight_booking_app/core/widgets/app_password_text_form_field.dart';
import 'package:flight_booking_app/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController? nameController;
  final TextEditingController? emailController;
  final TextEditingController? phoneController;
  final TextEditingController? passwordController;
  final TextEditingController? confirmPasswordController;
  final String? selectedCountry;
  final String? selectedCity;
  final Function(String?)? onCountryChanged;
  final Function(String?)? onCityChanged;
  final List<String>? countries;
  final List<String>? availableCities;
  const AuthForm({
    super.key,
    required this.formKey,
    this.nameController,
    this.emailController,
    this.phoneController,
    this.passwordController,
    this.confirmPasswordController,
    this.selectedCountry,
    this.selectedCity,
    this.onCountryChanged,
    this.onCityChanged,
    this.countries,
    this.availableCities,
  });
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          if (nameController != null) ...[
            AppTextFormField(
              controller: nameController!,
              labelText: "Name",
              hintText: "Enter Name",
              prefixIcon: Icons.person_outline,
            ),
            const SizedBox(height: 20),
          ],
          if (emailController != null) ...[
            AppTextFormField(
              controller: emailController!,
              labelText: "Email Address",
              hintText: "Enter Email",
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: 20),
          ],
          if (phoneController != null) ...[
            AppTextFormField(
              controller: phoneController!,
              labelText: "Mobile Number",
              hintText: "Enter Mobile Number",
              prefixIcon: Icons.phone_outlined,
            ),
            const SizedBox(height: 20),
          ],
          if (countries != null && onCountryChanged != null) ...[
            AppDropdownButtonFormField<String>(
              value: selectedCountry,
              labelText: "Select Country",
              prefixIcon: Icons.flag_outlined,
              items: countries!
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: onCountryChanged,
              validator: (v) =>
                  v == null || v.isEmpty ? "Country is required" : null,
            ),
            const SizedBox(height: 20),
          ],
          if (availableCities != null && onCityChanged != null) ...[
            AppDropdownButtonFormField<String>(
              value: selectedCity,
              labelText: "Select City",
              prefixIcon: Icons.location_city_outlined,
              items: availableCities!
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: onCityChanged,
              validator: (v) =>
                  v == null || v.isEmpty ? "City is required" : null,
            ),
            const SizedBox(height: 20),
          ],
          if (passwordController != null) ...[
            AppPasswordTextFormField(
              controller: passwordController!,
              labelText: "Password",
              hintText: "Enter Password",
            ),
            const SizedBox(height: 20),
          ],
          if (confirmPasswordController != null) ...[
            AppPasswordTextFormField(
              controller: confirmPasswordController!,
              labelText: "Confirm Password",
              hintText: "Confirm Password",
            ),
          ],
        ],
      ),
    );
  }
}
