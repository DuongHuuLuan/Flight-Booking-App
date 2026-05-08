import 'package:flight_booking_app/data/mock/location_data.dart';
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
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: "Name",
              labelStyle: TextStyle(color: Colors.grey.shade400),
              floatingLabelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              hintText: "Enter Name",
              hintStyle: TextStyle(color: Colors.grey.shade300),
              prefixIcon: Icon(
                Icons.person_outline,
                color: Colors.grey.shade400,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: (value) => (value == null || value.trim().isEmpty)
                ? "Name is required"
                : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Email Address",
              labelStyle: TextStyle(color: Colors.grey.shade400),
              floatingLabelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              hintText: "Enter Email",
              hintStyle: TextStyle(color: Colors.grey.shade300),
              prefixIcon: Icon(
                Icons.email_outlined,
                color: Colors.grey.shade400,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: (value) => (value == null || value.trim().isEmpty)
                ? "Email is required"
                : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: phoneController,
            decoration: InputDecoration(
              labelText: "Mobile Number",
              labelStyle: TextStyle(color: Colors.grey.shade400),
              floatingLabelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              hintText: "Enter Mobile Number",
              hintStyle: TextStyle(color: Colors.grey.shade300),
              prefixIcon: Icon(
                Icons.phone_outlined,
                color: Colors.grey.shade400,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: (value) => (value == null || value.trim().isEmpty)
                ? "Mobile Number is required"
                : null,
          ),
          const SizedBox(height: 20),

          DropdownButtonFormField<String>(
            value: selectedCountry,
            decoration: InputDecoration(
              labelText: "Select Country",
              labelStyle: TextStyle(color: Colors.grey.shade400),
              floatingLabelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              prefixIcon: Icon(
                Icons.flag_outlined,
                color: Colors.grey.shade400,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: LocationData.countries.map((String country) {
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
          DropdownButtonFormField<String>(
            value: selectedCity,
            decoration: InputDecoration(
              labelText: "Select City",
              labelStyle: TextStyle(color: Colors.grey.shade400),
              floatingLabelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              prefixIcon: Icon(
                Icons.location_city_outlined,
                color: Colors.grey.shade400,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: selectedCountry != null
                ? LocationData.citiesByCountry[selectedCountry]?.map((
                        String city,
                      ) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        );
                      }).toList() ??
                      []
                : [],
            onChanged: onCityChanged,
            validator: (value) => (value == null || value.isEmpty)
                ? "Select City is required"
                : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              labelStyle: TextStyle(color: Colors.grey.shade400),
              floatingLabelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              suffixIcon: Icon(
                Icons.visibility_off_outlined,
                color: Colors.grey.shade300,
              ),
              hintText: "Enter Password",
              hintStyle: TextStyle(color: Colors.grey.shade300),
              prefixIcon: Icon(Icons.lock_outline, color: Colors.grey.shade400),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: (value) => (value == null || value.trim().isEmpty)
                ? "Password is required"
                : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Confirm Password",
              labelStyle: TextStyle(color: Colors.grey.shade400),
              floatingLabelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              suffixIcon: Icon(
                Icons.visibility_off_outlined,
                color: Colors.grey.shade300,
              ),
              hintText: "Confirm Password",
              hintStyle: TextStyle(color: Colors.grey.shade300),
              prefixIcon: Icon(Icons.lock_outline, color: Colors.grey.shade400),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: (value) => (value == null || value.trim().isEmpty)
                ? "Confirm Password is required"
                : null,
          ),
        ],
      ),
    );
  }
}
