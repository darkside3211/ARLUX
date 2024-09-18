import 'package:flutter/material.dart';

class FailureWidget {
  Widget iconedFailure(BuildContext context, String message) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.warning,
            color: Colors.deepOrange,
          ),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
