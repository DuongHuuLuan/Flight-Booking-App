import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppDropdownButtonFormField<T> extends StatelessWidget {
  final T? value;
  final String labelText;
  final IconData prefixIcon;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;

  const AppDropdownButtonFormField({
    super.key,
    required this.value,
    required this.labelText,
    required this.prefixIcon,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: AppColor.grey),
        floatingLabelStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        prefixIcon: Icon(prefixIcon, color: AppColor.grey),
        filled: true,
        fillColor: AppColor.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.greyLight),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      items: items,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
