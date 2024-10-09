import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/core/utils/currency_format.dart';
import 'package:jbb_app_v5/features/cart/model/cart_model.dart';
import 'package:jbb_app_v5/features/products/model/product_model.dart';
import 'package:jbb_app_v5/presentation/pages/product/product_detail.dart';
import 'package:jbb_app_v5/presentation/providers/cart_to_product.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_image.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_widget.dart';

abstract class ProductCard {}

class ProductThumbnail extends ConsumerWidget implements ProductCard {
  final ProductModel productModel;
  final Color? cardColor;

  const ProductThumbnail({
    super.key,
    required this.productModel,
    this.cardColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: cardColor,
      child: InkWell(
        onTap: () {
          ref.read(selectedProductIdProvider.notifier).state = productModel.id;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductDetail(
                productModel: productModel,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomSingleImage(
                image: productModel.imageUrls[0],
                disableGestures: true,
                aspectRatio: 1 / 1,
                isNetwork: false,
              ),
              const Divider(height: 16),
              Text(
                productModel.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              ProductPriceBuilder(price: productModel.price),
              gapH4,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (productModel.modelUrl.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey.shade300
                      ),
                      padding: const EdgeInsets.all(2),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.view_in_ar,
                            size: 12,
                          ),
                          Text(
                            '3D view',
                            style: TextStyle(fontSize: 8),
                          ),
                        ],
                      ),
                    ),
                  gapW4,
                  if (productModel.lensID.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey.shade300
                      ),
                      padding: const EdgeInsets.all(2),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.camera_enhance_outlined,
                            size: 12,
                          ),
                          Text(
                            'Try-on',
                            style: TextStyle(fontSize: 8),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              gapH16,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  Text("${productModel.averageRating.toString()} | "),
                  Text(
                    '${compactNumerFormat(value: productModel.soldCount)} sold',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductFeatureCard extends ConsumerWidget implements ProductCard {
  final ProductModel productModel;

  const ProductFeatureCard({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: Colors.amber.shade50,
      child: InkWell(
        onTap: () {
          ref.read(selectedProductIdProvider.notifier).state = productModel.id;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductDetail(
                productModel: productModel,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomSingleImage(
                image: productModel.imageUrls[0],
                disableGestures: true,
                aspectRatio: 1 / 1,
                isNetwork: false,
              ),
              const Divider(height: 16),
              Text(
                productModel.name,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              ProductPriceBuilder(price: productModel.price),
              ProductRatingBuilder(rating: productModel.averageRating),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final CartModel cartModel;
  final bool isEditing; // Pass editing state

  const ProductTile({
    super.key,
    required this.cartModel,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    double totalPrice = cartModel.price;

    if (cartModel.quantity > 0) {
      totalPrice = cartModel.quantity * cartModel.price;
    }
    return Card(
      child: ListTile(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDetail(
                  productModel:
                      CartToProduct(cartModel: cartModel).getConvertedProduct(),
                ),
              ),
            );
          },
          child: CustomSingleImage(
            image: cartModel.imageUrls[0],
            disableGestures: true,
            aspectRatio: 1 / 1,
            isNetwork: false,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                cartModel.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            // Conditionally render checkbox in edit mode
            if (isEditing)
              Checkbox(
                value: false,
                onChanged: (value) {
                  // Handle checkbox state
                },
              ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quantity: ${cartModel.quantity.toString()}",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  "Size: ${cartModel.size}",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            ProductPriceBuilder(
              price: totalPrice,
              textStyle: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
