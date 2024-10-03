import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/features/cart/data/cart_repository.dart';
import 'package:jbb_app_v5/features/cart/model/cart_model.dart';
import 'package:jbb_app_v5/features/products/model/product_model.dart';
import 'package:jbb_app_v5/presentation/pages/cart/cart_bottom_sheet.dart';
import 'package:jbb_app_v5/presentation/pages/home/product_detail.dart';
import 'package:jbb_app_v5/presentation/providers/cart_to_product.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_image.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
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

class ProductTile extends ConsumerWidget {
  final CartModel cartModel;

  const ProductTile({
    super.key,
    required this.cartModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double totalPrice = cartModel.price;

    if (cartModel.quantity > 0) {
      totalPrice = cartModel.quantity * cartModel.price;
    }

    return Slidable(
      endActionPane: ActionPane(motion: const DrawerMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            _showModifySheet(context);
          },
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
          icon: Icons.edit,
          label: 'Modify',
        ),
        SlidableAction(
          onPressed: (context) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Delete Item'),
                  content: Text(
                      '...${cartModel.name}...\nAre you sure you want to delete this item from the cart?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Cancel
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        bool confirmed = await ref.read(
                            removeBagItemsProvider(cartIDs: [cartModel.cartID])
                                .future);

                        if (confirmed) {
                          // ignore: use_build_context_synchronously
                          SnackBarFailure(context,
                              message: "Successfully removed to bag.");
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        } else {
                          // ignore: use_build_context_synchronously
                          SnackBarFailure(context,
                              message: "Failed to remove to bag.");
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.amber),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.black,
          icon: Icons.delete,
          label: 'Delete',
        ),
      ]),
      child: Card(
        child: InkWell(
          onTap: () {
            ref.read(selectedProductIdProvider.notifier).state = cartModel.id;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDetail(
                  productModel:
                      CartToProduct(cartModel: cartModel).getConvertedProduct(),
                ),
              ),
            );
          },
          child: ListTile(
            leading: CustomSingleImage(
              image: cartModel.imageUrls[0],
              disableGestures: true,
              aspectRatio: 1 / 1,
              isNetwork: false,
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    cartModel.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const Icon(Icons.arrow_circle_left_outlined),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
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
        ),
      ),
    );
  }

  void _showModifySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the bottom sheet to take full height
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, // Handle keyboard overlap
          ),
          child: EditCartBottomSheet(
            cartModel: cartModel,
          ),
        );
      },
    );
  }
}
