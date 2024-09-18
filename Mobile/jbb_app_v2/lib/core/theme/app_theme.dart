import 'package:flutter/material.dart';
import 'package:jbb_app_v2/core/theme/theme_colors.dart';

ThemeData theme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: _appBarTheme(),
    textTheme: _textTheme(),
    
  );
}

AppBarTheme _appBarTheme() {
  return const AppBarTheme(
    backgroundColor: secondaryBlack,
    iconTheme: IconThemeData(color: secondaryAmber),
    actionsIconTheme: IconThemeData(color: primaryAmber),
  );
}

TextTheme _textTheme() {
  return const TextTheme(
    titleLarge: TextStyle(
        fontFamily: 'DMSans', fontWeight: FontWeight.bold, color: Colors.black),
    titleMedium: TextStyle(
        fontFamily: 'DMSans', fontWeight: FontWeight.w400, color: Colors.black),
    titleSmall: TextStyle(fontFamily: 'DMSans', fontWeight: FontWeight.w100),
  );
}
