import 'package:flutter/material.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/core/utils/currency_format.dart';

abstract class ProductWidget {}

class ProductPriceBuilder extends StatelessWidget implements ProductWidget {
  final double price;
  final TextStyle? textStyle;

  const ProductPriceBuilder({super.key, required this.price, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      currencyFormat(value: price),
      style: textStyle?.copyWith(
              color: AppColors.black, fontWeight: FontWeight.bold) ??
          Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: AppColors.black, fontWeight: FontWeight.bold),
    );
  }
}

class ProductRatingBuilder extends StatelessWidget implements ProductWidget {
  final double rating;
  final int maxRating;
  final double size;
  final Color filledColor;
  final Color halfFilledColor;
  final Color unfilledColor;

  const ProductRatingBuilder({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 24,
    this.filledColor = Colors.amber,
    this.halfFilledColor = AppColors.yellow,
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
        gapW8,
        Text(
          rating.toStringAsFixed(1),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
