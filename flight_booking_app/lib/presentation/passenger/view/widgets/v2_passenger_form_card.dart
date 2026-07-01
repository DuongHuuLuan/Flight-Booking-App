import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/domain/enums/age_group.dart';
import 'package:flight_booking_app/presentation/passenger/cubit/passenger_state.dart';
import 'package:flutter/material.dart';

class V2PassengerFormCard extends StatelessWidget {
  final PassengerFormData formData;
  final int index;
  final void Function(String field, dynamic value) onUpdateField;

  const V2PassengerFormCard({
    super.key,
    required this.formData,
    required this.index,
    required this.onUpdateField,
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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Text(
                  'Passenger $index',
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                _InfoChip(label: 'Seat ${formData.seatLabel}'),
                const SizedBox(width: 8),
                _InfoChip(label: formData.ageGroup.displayName),
              ],
            ),
          ),

          _FormTextField(
            label: 'Full Name *',
            initialValue: formData.name,
            icon: Icons.person,
            onChanged: (v) => onUpdateField('name', v),
          ).paddingOnly(left: 16, top: 0, right: 16, bottom: 8),

          _FormTextField(
            label: 'Mobile Phone *',
            initialValue: formData.mobilePhone,
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
            onChanged: (v) => onUpdateField('mobilePhone', v),
          ).paddingOnly(left: 16, top: 0, right: 16, bottom: 8),

          _DateField(
            formData: formData,
            onDatePicked: (d) => onUpdateField('dateOfBirth', d),
          ).paddingOnly(left: 16, top: 0, right: 16, bottom: 8),

          _FormTextField(
            label: 'Passport Number',
            initialValue: formData.passportNumber,
            icon: Icons.assignment_ind,
            onChanged: (v) => onUpdateField('passportNumber', v),
          ).paddingOnly(left: 16, top: 0, right: 16, bottom: 8),

          _FormTextField(
            label: 'Nationality',
            initialValue: formData.nationality,
            icon: Icons.flag,
            onChanged: (v) => onUpdateField('nationality', v),
          ).paddingOnly(left: 16, top: 0, right: 16, bottom: 8),

          _FormTextField(
            label: 'Address',
            initialValue: formData.address,
            icon: Icons.home,
            onChanged: (v) => onUpdateField('address', v),
          ).paddingOnly(left: 16, top: 0, right: 16, bottom: 8),

          _FormTextField(
            label: 'Email',
            initialValue: formData.email,
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            onChanged: (v) => onUpdateField('email', v),
          ).paddingOnly(left: 16, top: 0, right: 16, bottom: 8),

          _FormTextField(
            label: 'ID Number',
            initialValue: formData.idNumber,
            icon: Icons.badge,
            onChanged: (v) => onUpdateField('idNumber', v),
          ).paddingOnly(left: 16, top: 0, right: 16, bottom: 8),

          _BaggageDropdown(
            baggageLevel: formData.baggageLevel,
            onChanged: (v) => onUpdateField('baggageLevel', v ?? ''),
          ).paddingOnly(left: 16, top: 0, right: 16, bottom: 8),
          const SizedBox(height: 8),
        ],
      ),
    ).paddingAll(16);
  }
}

class _FormTextField extends StatefulWidget {
  final String label;
  final String initialValue;
  final IconData icon;
  final TextInputType? keyboardType;
  final ValueChanged<String> onChanged;

  const _FormTextField({
    required this.label,
    required this.initialValue,
    required this.icon,
    this.keyboardType,
    required this.onChanged,
  });

  @override
  State<_FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<_FormTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: Icon(widget.icon, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
      keyboardType: widget.keyboardType,
      controller: _controller,
      onChanged: widget.onChanged,
    );
  }
}

class _DateField extends StatelessWidget {
  final PassengerFormData formData;
  final ValueChanged<DateTime> onDatePicked;

  const _DateField({required this.formData, required this.onDatePicked});

  @override
  Widget build(BuildContext context) {
    final dateStr = formData.dateOfBirth != null
        ? '${formData.dateOfBirth!.day}/${formData.dateOfBirth!.month}/${formData.dateOfBirth!.year}'
        : '';
    return TextField(
      decoration: InputDecoration(
        labelText: 'Date of Birth',
        prefixIcon: const Icon(Icons.calendar_today, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
      controller: TextEditingController(text: dateStr),
      readOnly: true,
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: formData.dateOfBirth ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          onDatePicked(picked);
        }
      },
    );
  }
}

class _BaggageDropdown extends StatelessWidget {
  final String baggageLevel;
  final ValueChanged<String?> onChanged;

  const _BaggageDropdown({required this.baggageLevel, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final levels = ['', 'economy', 'standard', 'premium'];
    return DropdownButtonFormField<String>(
      initialValue: baggageLevel.isEmpty ? null : baggageLevel,
      decoration: InputDecoration(
        labelText: 'Baggage Level',
        prefixIcon: const Icon(Icons.luggage, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
      items: [
        const DropdownMenuItem(value: null, child: Text('Select baggage')),
        for (final l in levels.where((l) => l.isNotEmpty))
          DropdownMenuItem(
            value: l,
            child: Text(l[0].toUpperCase() + l.substring(1)),
          ),
      ],
      onChanged: onChanged,
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  const _InfoChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColor.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(color: AppColor.primary),
      ),
    );
  }
}

extension on AgeGroup {
  String get displayName {
    return switch (this) {
      AgeGroup.child => 'Child',
      AgeGroup.adult => 'Adult',
      AgeGroup.senior => 'Senior',
    };
  }
}
