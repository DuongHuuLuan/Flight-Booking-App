import 'package:flight_booking_app/core/widgets/app_password_text_form_field.dart';
import 'package:flight_booking_app/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AppTextFormField(
            controller: emailController,
            labelText: "Email Address",
            hintText: "Enter Email",
            prefixIcon: Icons.email_outlined,
          ),

          const SizedBox(height: 20),
          AppPasswordTextFormField(
            controller: passwordController,
            labelText: "Password",
            hintText: "Enter Password",
          ),
        ],
      ),
    );
  }
}
