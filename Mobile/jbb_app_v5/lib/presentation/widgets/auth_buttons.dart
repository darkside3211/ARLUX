import 'package:flutter/material.dart';

class AuthButtons {
  Widget authButton({VoidCallback? onPressed, required String buttonText}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.amber,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget googleAuthButton(VoidCallback? onPressed, {bool isLogin = false}) {
    return InkWell(
      onTap: onPressed,
      child: isLogin
          ? Image.asset(
              'assets/themes/googleButtons/signInWithGoogleButton.png')
          : Image.asset(
              'assets/themes/googleButtons/signUpWithGoogleButton.png'),
    );
  }
}
