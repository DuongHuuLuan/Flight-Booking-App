import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/presentation/passenger/view/widgets/passenger_date_field.dart';
import 'package:flight_booking_app/presentation/passenger/view/widgets/passenger_form_field.dart';
import 'package:flight_booking_app/presentation/passenger/view/widgets/passenger_nationality_field.dart';
import 'package:flutter/material.dart';

class PassengerFormData {
  final TextEditingController nameController;
  final TextEditingController mobilePhoneController;
  final TextEditingController dobController;
  final TextEditingController passportController;
  final TextEditingController nationalityController;

  PassengerFormData()
      : nameController = TextEditingController(),
        mobilePhoneController = TextEditingController(),
        dobController = TextEditingController(),
        passportController = TextEditingController(),
        nationalityController = TextEditingController();

  void dispose() {
    nameController.dispose();
    mobilePhoneController.dispose();
    dobController.dispose();
    passportController.dispose();
    nationalityController.dispose();
  }
}

class PassengerFormCard extends StatelessWidget {
  final PassengerFormData formData;
  final int index;

  const PassengerFormCard({
    super.key,
    required this.formData,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      color: AppColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Passenger $index',
            style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
          ).paddingHorizontal(16).paddingTop(16),
          const SizedBox(height: 16),
          PassengerFormField(
            controller: formData.nameController,
            label: 'Name',
            prefixIcon: Icons.person,
          ),
          PassengerFormField(
            controller: formData.mobilePhoneController,
            label: 'Mobile Phone',
            prefixIcon: Icons.phone,
            keyboardType: TextInputType.phone,
          ),
          PassengerDateField(controller: formData.dobController),
          PassengerFormField(
            controller: formData.passportController,
            label: 'Passport Number',
            prefixIcon: Icons.assignment_ind,
          ),
          PassengerNationalityField(controller: formData.nationalityController),
          const SizedBox(height: 8),
        ],
      ),
    ).paddingAll(16);
  }
}
