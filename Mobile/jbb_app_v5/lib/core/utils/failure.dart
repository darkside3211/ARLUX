import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Failure {
  static void showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.grey[850],
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
