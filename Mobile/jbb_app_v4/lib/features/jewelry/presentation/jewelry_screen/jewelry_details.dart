import 'package:flutter/material.dart';
import 'package:jbb_app_v4/common/widgets/cart_button_widget.dart';
import 'package:jbb_app_v4/common/widgets/price_builder.dart';
import 'package:jbb_app_v4/common/widgets/rating_builder.dart';
import 'package:jbb_app_v4/common/widgets/wishlist_button_widget.dart';
import 'package:jbb_app_v4/core/constants/app_sizes.dart';
import 'package:jbb_app_v4/core/utils/currency_format.dart';
import 'package:jbb_app_v4/features/jewelry/models/jewelry_model.dart';
import 'package:jbb_app_v4/features/jewelry/presentation/app_bars/bottom_buy_cart_bar.dart';
import 'package:jbb_app_v4/features/jewelry/presentation/app_bars/jewelry_detail_app_bar.dart';
import 'package:jbb_app_v4/features/jewelry/presentation/jewelry_list/jewelry_grid.dart';
import 'package:jbb_app_v4/features/jewelry/presentation/jewelry_list/jewelry_model_viewer.dart';

class JewelryDetails extends StatelessWidget {
  const JewelryDetails({super.key, required this.jewelryModel});

  final JewelryModel jewelryModel;

  @override
  Widget build(BuildContext context) {
    final String price = currencyFormat(value: jewelryModel.price);
    return Scaffold(
      appBar: JewelryDetailTopBar(jewelryName: jewelryModel.name),
      bottomNavigationBar: const BottomBuyCartBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: JewelryModelViewer(
                modelUrl: 'assets/models/${jewelryModel.modelUrl}',
                imageUrls: jewelryModel.imageUrls,
              ),
            ),
            gapH16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: PriceBuilder(
                    price: price,
                    textStyle: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const CartIconButtonWidget(),
                const WishlistButtonNonAvatar(),
              ],
            ),
            Text(
              jewelryModel.name,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            gapH8,
            RatingBuilder(rating: jewelryModel.averageRating),
            const Divider(
              height: Sizes.p32,
            ),
            Text(
              "${jewelryModel.category}'s Detail",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            gapH8,
            Text(
              jewelryModel.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Divider(
              height: Sizes.p32,
            ),
            Text(
              'Reviews',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            gapH8,
            const Divider(
              height: Sizes.p32,
            ),
            Text(
              'You might also like',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            gapH8,
            JewelrySearchResultsImpl(isScrollable: false, isRecommendation: true, q: '${jewelryModel.name} ${jewelryModel.category}'),
            const Divider(
              height: Sizes.p32,
            ),
          ],
        ),
      ),
    );
  }
}
