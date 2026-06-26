import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/widgets/app_elevated_button.dart';
import 'package:flight_booking_app/domain/entities/payment_method_entity.dart';
import 'package:flutter/material.dart';

class AddCardScreen extends StatefulWidget {
  static String get routerName => '/add-card';
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _holderController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _holderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;

    final raw = _cardNumberController.text.replaceAll(' ', '');
    final masked = '•••• ${raw.substring(raw.length - 4)}';
    final type = raw.startsWith('4') ? 'Visa' : 'Mastercard';

    final card = PaymentMethodEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      maskedNumber: masked,
      cardHolderName: _holderController.text,
      expiryDate: _expiryController.text,
      cardType: type,
      isDefault: false,
    );

    Navigator.of(context).pop(card);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text('Add New Card', style: AppTextStyles.heading3),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: _cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  hintText: '1234 5678 9012 3456',
                ),
                keyboardType: TextInputType.number,
                maxLength: 19,
                validator: (v) {
                  if (v == null || v.replaceAll(' ', '').length < 16) {
                    return 'Enter a valid 16-digit card number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _holderController,
                decoration: const InputDecoration(
                  labelText: 'Card Holder Name',
                  hintText: 'John Doe',
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Name is required' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _expiryController,
                      decoration: const InputDecoration(
                        labelText: 'Expiry Date',
                        hintText: 'MM/YY',
                      ),
                      maxLength: 5,
                      validator: (v) => v == null || v.length < 5
                          ? 'Enter valid expiry'
                          : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _cvvController,
                      decoration: const InputDecoration(
                        labelText: 'CVV',
                        hintText: '123',
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      obscureText: true,
                      validator: (v) =>
                          v == null || v.length < 3 ? 'Enter valid CVV' : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppElevatedButton(
        label: 'Add Card',
        height: MediaQuery.of(context).size.height * 0.06,
        backgroundColor: AppColor.primary,
        onPressed: _onSave,
      ).paddingOnly(bottom: 30, left: 20, right: 20),
    );
  }
}
