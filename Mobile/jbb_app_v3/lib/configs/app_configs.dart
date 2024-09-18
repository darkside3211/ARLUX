import 'package:flutter/material.dart';

class AppConfigs {
  static String baseUrl = 'http://localhost:8000/';

  static double getSreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
 