import 'package:flutter/material.dart';

abstract class InputFields {}

class EmailPasswordField implements InputFields {
  final BuildContext context;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  EmailPasswordField(
    this.context,
  );

  String getUsername() => _usernameController.text;
  String getEmail() => _emailController.text;
  String getPassword() => _passwordController.text;

  TextField username() {
    return TextField(
      controller: _usernameController,
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: 'username',
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

  TextField emailAddress() {
    return TextField(
      controller: _emailController,
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

  TextField password() {
    return TextField(
      obscureText: true,
      controller: _passwordController,
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
