import 'package:flutter/material.dart';

abstract class InputFields {}

class EmailPasswordField implements InputFields {
  final BuildContext context;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  EmailPasswordField(
    this.context,
  );

  String getEmail() => emailController.text;
  String getPassword() => passwordController.text;

  Widget emailAddress() {
    return TextField(
      controller: emailController,
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'email',
        labelStyle: TextStyle(color: Colors.amber[100]),
        filled: true,
        fillColor: Colors.white24,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.amber),
        ),
      ),
    );
  }

  Widget password() {
    return TextField(
      obscureText: true,
      controller: passwordController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'password',
        labelStyle: TextStyle(color: Colors.amber[100]),
        filled: true,
        fillColor: Colors.white24,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.amber),
        ),
      ),
    );
  }
}
