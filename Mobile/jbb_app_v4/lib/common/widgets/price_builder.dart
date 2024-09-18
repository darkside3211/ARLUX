import 'package:flutter/material.dart';

class PriceBuilder extends StatelessWidget {
  final String price;
  final TextStyle? textStyle;
  const PriceBuilder({super.key, this.textStyle, required this.price,});

  @override
  Widget build(BuildContext context) {
    return Text(
      price,
      style: textStyle?.copyWith(color: Colors.amber, fontWeight: FontWeight.bold) ?? Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: Colors.amber, fontWeight: FontWeight.bold),
    );
  }
}