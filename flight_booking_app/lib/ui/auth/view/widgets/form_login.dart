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
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              labelStyle: TextStyle(color: Colors.grey.shade400),
              floatingLabelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              hintText: "Enter Password",
              hintStyle: TextStyle(color: Colors.grey.shade300),
              prefixIcon: Icon(Icons.lock_outline, color: Colors.grey.shade400),
              suffixIcon: Icon(
                Icons.visibility_off_outlined,
                color: Colors.grey.shade300,
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
                ? "Password is required"
                : null,
          ),
        ],
      ),
    );
  }
}
