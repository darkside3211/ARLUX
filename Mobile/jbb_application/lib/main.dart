import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jbb_application/pages/product_details_page.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.amber,
        statusBarIconBrightness: Brightness.dark));
    return MaterialApp(
      title: 'JBB Jewelry Store',
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff292929),
            foregroundColor: Colors.amber,
            shape:
                const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
          )),
          textTheme: GoogleFonts.dmSansTextTheme(),
          primarySwatch: Colors.amber,
          iconTheme: const IconThemeData(color: Colors.amber),
          iconButtonTheme: const IconButtonThemeData(
              style: ButtonStyle(
                  iconColor: WidgetStatePropertyAll(Colors.amber)))),
      debugShowCheckedModeBanner: false,
      home: const ProductDetailsPage(),
    );
  }
}
