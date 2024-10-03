import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class FailureWidget {}

class IconedFailure extends StatelessWidget implements FailureWidget {
  final String message;
  final Icon displayIcon;

  const IconedFailure(
      {super.key, required this.message, required this.displayIcon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          displayIcon,
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}

class ToastFailure implements FailureWidget {
  ToastFailure({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.grey[850],
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}

class SnackBarFailure implements FailureWidget {
  SnackBarFailure(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
