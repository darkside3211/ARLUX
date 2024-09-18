import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String id;
  final String name;
  final double price;
  final String thumbnailUrl;
  final int rating;

  const ProductCard(
      {super.key,
      required this.id,
      required this.name,
      required this.price,
      required this.thumbnailUrl,
      this.rating = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.amberAccent
      ),
      child: Center(
        child: Text(name)),
    );
  }
}

