import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/core/network/network_core.dart';
import 'package:jbb_app_v5/core/utils/formats.dart';
import 'package:jbb_app_v5/features/cart/model/cart_model.dart';
import 'package:jbb_app_v5/features/order/model/order_model.dart';
import 'package:jbb_app_v5/features/products/data/product_remote_repository.dart';
import 'package:jbb_app_v5/features/products/model/product_model.dart';
import 'package:jbb_app_v5/presentation/pages/order/checkout_result.dart';
import 'package:jbb_app_v5/presentation/pages/product/product_detail.dart';
import 'package:jbb_app_v5/presentation/pages/rating/rating_bottom_sheet.dart';
import 'package:jbb_app_v5/presentation/providers/cart_to_product.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_buttons.dart';
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
          ref.read(selectedProductProvider.notifier).state = productModel;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ProductDetail(),
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
                isNetwork: true,
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
                          color: Colors.grey.shade300),
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
                          color: Colors.grey.shade300),
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
          ref.read(selectedProductProvider.notifier).state = productModel;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ProductDetail(),
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
                isNetwork: true,
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

class OrderTile extends ConsumerWidget {
  final OrderModel orderModel;
  const OrderTile({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget buildProducts() {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: orderModel.productItems.length,
        itemBuilder: (context, index) {
          final product = orderModel.productItems[index];
          return Card(
            child: ListTile(
              onTap: () async {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  ),
                );

                final productDetail = await ref.read(
                    getSingleProductProvider(productId: product.productID)
                        .future);

                if (context.mounted) {
                  Navigator.of(context, rootNavigator: true).pop();

                  if (productDetail != null) {
                    ref.read(selectedProductProvider.notifier).state =
                        productDetail;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProductDetail(),
                      ),
                    );
                  }
                }
              },
              leading: product.images != null
                  ? CustomSingleImage(
                      image: product.images![0],
                      disableGestures: true,
                      aspectRatio: 1,
                      isNetwork: true,
                    )
                  : const Icon(Icons.image),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    "Size: ${product.size}",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ProductPriceBuilder(price: product.amount),
                      Text(' x${product.quantity}')
                    ],
                  ),
                  if (orderModel.orderStatus == 'Completed')
                    TextButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => RatingBottomSheet(
                            productId: product.productID,
                          ),
                        );
                      },
                      icon: const Text(
                        'Rate Now',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.black),
                      ),
                      label: const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    )
                ],
              ),
              isThreeLine: true,
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Subtotal:'),
                  ProductPriceBuilder(price: product.amount * product.quantity),
                ],
              ),
            ),
          );
        },
      );
    }

    return Card(
        child: InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(formatDate(orderModel.updatedAt)),
            gapH8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'List Items (${orderModel.productItems.length})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  orderModel.orderStatus,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            buildProducts(),
            const Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (orderModel.deliveryAmount > 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('Delivery Amount: '),
                            ProductPriceBuilder(
                                price: orderModel.deliveryAmount)
                          ],
                        ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Total (${orderModel.productItems.length}): '),
                          ProductPriceBuilder(
                              price: orderModel.productItems.fold(
                                    0.0,
                                    (previousValue, element) {
                                      return previousValue +
                                          (element.amount * element.quantity);
                                    },
                                  ) +
                                  orderModel.deliveryAmount)
                        ],
                      ),
                    ],
                  ),
                  if (orderModel.checkoutUrl != null ||
                      orderModel.orderStatus == 'toPay')
                    CartElevatedButton(
                      isConfirm: true,
                      customFunction: () {
                        if (orderModel.checkoutUrl != null) {
                          LaunchCheckout(checkoutUrl: orderModel.checkoutUrl!);

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CheckoutResult()));
                        }
                      },
                      customLabel: 'Pay Now',
                    ),
                  if (orderModel.referenceNumber != "pending")
                    Row(
                      children: [
                        const Text("Tracking Number: "),
                        TextButton(
                          onPressed: () async {
                            await Clipboard.setData(ClipboardData(
                                text: orderModel.referenceNumber));
                            LaunchLBCTracking();
                          },
                          child: Text(orderModel.referenceNumber),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class ProductTile extends ConsumerWidget {
  final CartModel cartModel;
  final bool value;
  final bool isDefault;
  final Function(bool? value) onChanged;

  const ProductTile({
    super.key,
    required this.cartModel,
    required this.value,
    required this.onChanged,
    this.isDefault = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double totalPrice = cartModel.price;

    if (cartModel.quantity > 0) {
      totalPrice = (cartModel.price + cartModel.size.additionalAmount) *
          cartModel.quantity;
    }

    return Card(
      child: ListTile(
        isThreeLine: isDefault,
        leading: isDefault
            ? Checkbox(
                activeColor: AppColors.yellow,
                checkColor: AppColors.black,
                value: value,
                onChanged: onChanged,
              )
            : CustomSingleImage(
                image: cartModel.imageUrls[0],
                disableGestures: true,
                aspectRatio: 1,
                isNetwork: true,
              ),
        title: Text(
          cartModel.name,
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: isDefault
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ProductPriceBuilder(price: totalPrice),
                  Text(' | Qty: ${cartModel.quantity}')
                ],
              )
            : Row(
                children: [
                  ProductPriceBuilder(price: cartModel.price),
                  Text(' x${cartModel.quantity}')
                ],
              ),
        trailing: isDefault
            ? InkWell(
                onTap: () {
                  ref.read(selectedProductProvider.notifier).state =
                      CartToProduct(cartModel: cartModel).getConvertedProduct();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const ProductDetail();
                  }));
                },
                child: CustomSingleImage(
                  image: cartModel.imageUrls[0],
                  disableGestures: true,
                  aspectRatio: 1,
                  isNetwork: true,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Subtotal:'),
                  ProductPriceBuilder(price: totalPrice),
                ],
              ),
      ),
    );
  }
}

class CheckoutTile extends StatelessWidget {
  final CartModel checkoutItem;
  const CheckoutTile({
    super.key,
    required this.checkoutItem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {},
        leading: CustomSingleImage(
          image: checkoutItem.imageUrls[0],
          disableGestures: true,
          aspectRatio: 1,
          isNetwork: true,
        ),
        title: Text("${checkoutItem.name} (${checkoutItem.quantity})"),
        subtitle: ProductPriceBuilder(
            price: checkoutItem.quantity * checkoutItem.price),
        isThreeLine: true,
      ),
    );
  }
}
