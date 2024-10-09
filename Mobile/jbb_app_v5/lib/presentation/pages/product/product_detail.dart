import 'package:flutter/material.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/core/utils/currency_format.dart';
import 'package:jbb_app_v5/features/products/model/product_model.dart';
import 'package:jbb_app_v5/presentation/widgets/app_bars.dart';
import 'package:jbb_app_v5/presentation/widgets/bottom_bars.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_grid.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_viewer.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_widget.dart';

class ProductDetail extends StatelessWidget {
  final ProductModel productModel;

  const ProductDetail({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProductDetailTopBar(
        productName: productModel.name,
      ),
      bottomNavigationBar: ProductBuyCartBar(
        productId: productModel.id,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ProductViewer(
              imageUrls: productModel.imageUrls,
              modelUrl: productModel.modelUrl,
              lensID: productModel.lensID,
              groupID: productModel.groupID,
              isNetwork: false,
            ),
            gapH16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ProductPriceBuilder(
                    price: productModel.price,
                    textStyle: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            Text(
              productModel.name,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            gapH8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProductRatingBuilder(rating: productModel.averageRating),
                Text(' | ${compactNumerFormat(value: productModel.soldCount)} sold')
              ],
            ),
            const Divider(height: Sizes.p32),
            Text(
              "${productModel.category}'s Detail",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            gapH8,
            Text(
              productModel.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Divider(height: 32),
            Text(
              'Reviews',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            gapH8,
            const Divider(height: Sizes.p32),
            Text(
              'You might also like',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            gapH8,
            ProductSearchImpl(
              q: '${productModel.name} ${productModel.category}',
              isScrollable: false,
              isRecommendation: true,
            ),
            const Divider(height: Sizes.p32),
          ],
        ),
      )),
    );
  }
}
