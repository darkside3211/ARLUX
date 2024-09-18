import 'package:flutter/material.dart';
import 'package:jbb_app_v3/features/products/presentation/pages/product_list_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      showPerformanceOverlay: false,
      debugShowCheckedModeBanner: false,
      home: const ProductListPage(),
    );
  }
}
