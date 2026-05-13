import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;

  const AppTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: AppColor.grey),
        floatingLabelStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: AppColor.greyLight),
        prefixIcon: Icon(prefixIcon, color: AppColor.grey),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColor.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.greyLight),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: validator,
    );
  }
}
