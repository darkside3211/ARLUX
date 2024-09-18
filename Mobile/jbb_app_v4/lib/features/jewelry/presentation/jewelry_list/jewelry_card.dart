import 'package:flutter/material.dart';
import 'package:jbb_app_v4/common/widgets/custom_image.dart';
import 'package:jbb_app_v4/common/widgets/price_builder.dart';
import 'package:jbb_app_v4/common/widgets/rating_builder.dart';
import 'package:jbb_app_v4/common/widgets/wishlist_button_widget.dart';
import 'package:jbb_app_v4/core/constants/app_sizes.dart';
import 'package:jbb_app_v4/core/utils/currency_format.dart';
import 'package:jbb_app_v4/features/jewelry/models/jewelry_model.dart';
import 'package:jbb_app_v4/features/jewelry/presentation/jewelry_screen/jewelry_details.dart';

class JewelryCard extends StatelessWidget {
  final JewelryModel jewelryModel;
  final Color? cardColor;

  const JewelryCard({
    super.key,
    required this.jewelryModel,
    this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    final String price = currencyFormat(value: jewelryModel.price);
    return Card(
      color: cardColor,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JewelryDetails(jewelryModel: jewelryModel),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                
                children: [
                  CustomImageSingle(image: jewelryModel.imageUrls[0]),
                  const Positioned(
                      top: 4, right: 8, child: WishlistButtonAvatar())
                ],
              ),
              gapH8,
              const Divider(),
              gapH8,
              Text(
                jewelryModel.name,
                maxLines: 1, // Limit to one line
                overflow:
                    TextOverflow.ellipsis, // Add ellipsis if title is too long
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              gapH8,
              PriceBuilder(price: price),
              gapH4,
              RatingBuilder(rating: jewelryModel.averageRating),
              gapH4,
            ],
          ),
        ),
      ),
    );
  }
}
