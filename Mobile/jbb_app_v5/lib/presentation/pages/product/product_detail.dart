import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/core/utils/formats.dart';
import 'package:jbb_app_v5/presentation/pages/rating/review_list.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/app_bars.dart';
import 'package:jbb_app_v5/presentation/widgets/bottom_bars.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_grid.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_viewer.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_widget.dart';

class ProductDetail extends ConsumerWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productModel = ref.watch(selectedProductProvider);
    return Scaffold(
      appBar: ProductDetailTopBar(
        productName: productModel!.name,
      ),
      bottomNavigationBar: const ProductBuyCartBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Column(
          children: [
            ProductViewer(
              imageUrls: productModel.imageUrls,
              modelUrl: productModel.modelUrl,
              lensID: productModel.lensID,
              groupID: productModel.groupID,
              isNetwork: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                      Text(
                          '${compactNumerFormat(value: productModel.stockCount)} in stock | ${compactNumerFormat(value: productModel.soldCount)} sold')
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
                  gapH8,
                  Text('Updated: ${formatDate(productModel.updatedAt)}'),
                  Text('Created: ${formatDate(productModel.createdAt)}'),
                  const Divider(height: 32),
                  Text(
                    'Reviews',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  ReviewList(productID: productModel.id),
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
            ),
          ],
        ),
      )),
    );
  }
}
