import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:jbb_app_v2/core/theme/app_theme.dart';
import 'package:jbb_app_v2/features/product_list/presentation/pages/home_page.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      // theme: theme(),
      theme: FlexThemeData.light(scheme: FlexScheme.yellowM3),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.amber),
      home: const HomePage(),
    );
  }
}
