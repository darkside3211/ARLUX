import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/features/products/model/product_model.dart';
import 'package:jbb_app_v5/presentation/pages/home/product_detail.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_buttons.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_image.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_widget.dart';

abstract class ProductCard {
  final ProductModel productModel;

  const ProductCard({required this.productModel});
}

class ProductThumbnail extends ConsumerWidget implements ProductCard {
  @override
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
              Stack(
                children: [
                  CustomSingleImage(
                    image: productModel.imageUrls[0],
                    disableGestures: true,
                    aspectRatio: 1 / 1,
                    isNetwork: false,
                  ),
                  const Positioned(
                    top: 4,
                    right: 8,
                    child: WishListIconButton(withBG: true),
                  ),
                ],
              ),
              const Divider(height: 16),
              Text(
                productModel.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              gapH8,
              ProductPriceBuilder(price: productModel.price),
              gapH4,
              ProductRatingBuilder(rating: productModel.averageRating),
              gapH4,
            ],
          ),
        ),
      ),
    );
  }
}

class ProductTile extends ConsumerWidget implements ProductCard {
  @override
  final ProductModel productModel;

  const ProductTile({super.key, required this.productModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double totalPrice = productModel.price;

    if (productModel.quantity != null) {
      totalPrice = productModel.quantity! * productModel.price;
    }

    return Card(
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
        child: ListTile(
          leading: CustomSingleImage(
            image: productModel.imageUrls[0],
            disableGestures: true,
            aspectRatio: 1 / 1,
            isNetwork: false,
          ),
          title: Text(
            productModel.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Quantity: ${productModel.quantity.toString()}",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    "Size: ${productModel.size}",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              ProductPriceBuilder(price: totalPrice),
            ],
          ),
          isThreeLine: true,
          trailing: IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                );

                final isProductRemoved = await ref.read(
                  removeBagItemProvider(productId: productModel.id).future,
                );

                // ignore: use_build_context_synchronously
                Navigator.of(context, rootNavigator: true).pop();

                if (isProductRemoved && context.mounted) {
                  SnackBarFailure(context,
                      message: "Successfully removed to bag!");
                } else {
                  ToastFailure(message: "Failed to removed to bag.");
                }
              },
              icon: const Icon(Icons.delete)),
        ),
      ),
    );
  }
}
