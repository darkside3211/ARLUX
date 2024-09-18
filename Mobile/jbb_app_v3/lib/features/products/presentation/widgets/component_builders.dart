import 'package:flutter/material.dart';

class RatingStarBuilder extends StatelessWidget {
  final double rating;
  final int maxRating;
  final double size;
  final Color filledColor;
  final Color halfFilledColor;
  final Color unfilledColor;

  const RatingStarBuilder({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 24.0,
    this.filledColor = Colors.amber,
    this.halfFilledColor = Colors.amberAccent,
    this.unfilledColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(maxRating, (index) {
            if (index < rating.floor()) {
              return Icon(
                Icons.star,
                color: filledColor,
                size: size,
              );
            } else if (index < rating) {
              return Icon(
                Icons.star_half,
                color: halfFilledColor,
                size: size,
              );
            } else {
              return Icon(
                Icons.star_border,
                color: unfilledColor,
                size: size,
              );
            }
          }),
        ),
        const SizedBox(width: 8.0),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

String priceBuild(double price) {
  return "₱${price.toStringAsFixed(2)}";
}
