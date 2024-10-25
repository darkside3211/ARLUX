import 'package:flutter/material.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';

abstract class InputFields {}

class EmailPasswordField implements InputFields {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String getEmail() => _emailController.text;
  String getPassword() => _passwordController.text;

  TextField emailAddress() {
    return TextField(
      controller: _emailController,
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      decoration: customInputDecoration(label: 'email'),
    );
  }

  TextField password() {
    return TextField(
      obscureText: true,
      controller: _passwordController,
      style: const TextStyle(color: Colors.white),
      decoration: customInputDecoration(label: 'password'),
    );
  }
}

InputDecoration customInputDecoration({required String label}) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(color: AppColors.yellow, fontSize: 14),
    filled: true,
    fillColor: Colors.white24,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.yellow),
    ),
  );
}
