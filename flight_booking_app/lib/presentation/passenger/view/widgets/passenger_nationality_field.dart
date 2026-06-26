import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/widgets/app_dropdown_button_form_field.dart';
import 'package:flutter/material.dart';

class PassengerNationalityField extends StatelessWidget {
  final TextEditingController controller;

  const PassengerNationalityField({
    super.key,
    required this.controller,
  });

  static const _nationalities = [
    'Afghanistan',
    'Albania',
    'Algeria',
    'Argentina',
    'Australia',
    'Austria',
    'Bangladesh',
    'Belgium',
    'Brazil',
    'Cambodia',
    'Canada',
    'China',
    'Colombia',
    'Croatia',
    'Cuba',
    'Denmark',
    'Egypt',
    'Ethiopia',
    'Finland',
    'France',
    'Germany',
    'Ghana',
    'Greece',
    'Hong Kong',
    'Hungary',
    'Iceland',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Ireland',
    'Israel',
    'Italy',
    'Jamaica',
    'Japan',
    'Jordan',
    'Kenya',
    'Kuwait',
    'Laos',
    'Malaysia',
    'Maldives',
    'Mexico',
    'Monaco',
    'Mongolia',
    'Morocco',
    'Myanmar',
    'Nepal',
    'Netherlands',
    'New Zealand',
    'Nigeria',
    'Norway',
    'Oman',
    'Pakistan',
    'Philippines',
    'Poland',
    'Portugal',
    'Qatar',
    'Romania',
    'Russia',
    'Saudi Arabia',
    'Singapore',
    'South Africa',
    'South Korea',
    'Spain',
    'Sri Lanka',
    'Sweden',
    'Switzerland',
    'Taiwan',
    'Tanzania',
    'Thailand',
    'Turkey',
    'Uganda',
    'Ukraine',
    'United Arab Emirates',
    'United Kingdom',
    'United States',
    'Vietnam',
    'Yemen',
    'Zimbabwe',
  ];

  @override
  Widget build(BuildContext context) {
    return AppDropdownButtonFormField<String>(
      value: controller.text.isEmpty ? null : controller.text,
      labelText: 'Nationality',
      prefixIcon: Icons.flag,
      isExpanded: true,
      items: _nationalities
          .map((n) => DropdownMenuItem(value: n, child: Text(n)))
          .toList(),
      onChanged: (v) {
        if (v != null) controller.text = v;
      },
    ).paddingHorizontal(16).paddingVertical(6);
  }
}
