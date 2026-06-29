import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/domain/enums/age_group.dart';
import 'package:flight_booking_app/presentation/passenger/cubit/passenger_state.dart';
import 'package:flutter/material.dart';

class V2PassengerFormCard extends StatelessWidget {
  final PassengerFormData formData;
  final int index;
  final VoidCallback onChanged;
  final void Function(String field, dynamic value) onUpdateField;

  const V2PassengerFormCard({
    super.key,
    required this.formData,
    required this.index,
    required this.onChanged,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: _buildField(
              label: 'Full Name *',
              value: formData.name,
              icon: Icons.person,
              onChanged: (v) {
                onUpdateField('name', v);
                onChanged();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: _buildField(
              label: 'Mobile Phone *',
              value: formData.mobilePhone,
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
              onChanged: (v) {
                onUpdateField('mobilePhone', v);
                onChanged();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: _buildDateField(context),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: _buildField(
              label: 'Passport Number',
              value: formData.passportNumber,
              icon: Icons.assignment_ind,
              onChanged: (v) => onUpdateField('passportNumber', v),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: _buildField(
              label: 'Nationality',
              value: formData.nationality,
              icon: Icons.flag,
              onChanged: (v) => onUpdateField('nationality', v),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: _buildField(
              label: 'Address',
              value: formData.address,
              icon: Icons.home,
              onChanged: (v) => onUpdateField('address', v),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: _buildField(
              label: 'Email',
              value: formData.email,
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              onChanged: (v) => onUpdateField('email', v),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: _buildField(
              label: 'ID Number',
              value: formData.idNumber,
              icon: Icons.badge,
              onChanged: (v) => onUpdateField('idNumber', v),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: _buildBaggageDropdown(),
          ),
          const SizedBox(height: 8),
        ],
      ),
    ).paddingAll(16);
  }

  Widget _buildField({
    required String label,
    required String value,
    required IconData icon,
    TextInputType? keyboardType,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      keyboardType: keyboardType,
      controller: TextEditingController.fromValue(
        TextEditingValue(text: value, selection: TextSelection.collapsed(offset: value.length)),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildDateField(BuildContext context) {
    final dateStr = formData.dateOfBirth != null
        ? '${formData.dateOfBirth!.day}/${formData.dateOfBirth!.month}/${formData.dateOfBirth!.year}'
        : '';
    return TextField(
      decoration: InputDecoration(
        labelText: 'Date of Birth',
        prefixIcon: const Icon(Icons.calendar_today, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
          onUpdateField('dateOfBirth', picked);
          onChanged();
        }
      },
    );
  }

  Widget _buildBaggageDropdown() {
    final levels = ['', 'economy', 'standard', 'premium'];
    return DropdownButtonFormField<String>(
      value: formData.baggageLevel.isEmpty ? null : formData.baggageLevel,
      decoration: InputDecoration(
        labelText: 'Baggage Level',
        prefixIcon: const Icon(Icons.luggage, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      items: [
        const DropdownMenuItem(value: null, child: Text('Select baggage')),
        for (final l in levels.where((l) => l.isNotEmpty))
          DropdownMenuItem(
            value: l,
            child: Text(l[0].toUpperCase() + l.substring(1)),
          ),
      ],
      onChanged: (v) {
        onUpdateField('baggageLevel', v ?? '');
        onChanged();
      },
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
