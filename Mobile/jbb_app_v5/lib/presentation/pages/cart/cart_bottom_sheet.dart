import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/features/auth/model/user_model.dart';
import 'package:jbb_app_v5/features/cart/data/cart_repository.dart';
import 'package:jbb_app_v5/features/cart/model/cart_model.dart';
import 'package:jbb_app_v5/features/order/model/order_model.dart';
import 'package:jbb_app_v5/presentation/pages/order/checkout_page.dart';
import 'package:jbb_app_v5/presentation/providers/cart_to_product.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_buttons.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';

abstract class CartBottomSheet {}

class BuyBottomSheet extends ConsumerStatefulWidget {
  const BuyBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BuyBottomSheetState();
}

class _BuyBottomSheetState extends ConsumerState<BuyBottomSheet> {
  int _quantity = 1;
  String _selectedSize = 'M';
  final List<String> _sizes = ['S', 'M', 'L', 'XL'];

  @override
  Widget build(BuildContext context) {
    final product = ref.watch(selectedProductProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Select Quantity and Size",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          gapH20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Quantity",
                style: TextStyle(fontSize: 16),
              ),
              gapW8,
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (_quantity > 1) _quantity--;
                      });
                    },
                  ),
                  Text(
                    '$_quantity',
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _quantity++;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          gapH20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Size",
                style: TextStyle(fontSize: 16),
              ),
              DropdownButton<String>(
                value: _selectedSize,
                items: _sizes.map((String size) {
                  return DropdownMenuItem<String>(
                    value: size,
                    child: Text(size),
                  );
                }).toList(),
                onChanged: (newSize) {
                  setState(() {
                    _selectedSize = newSize!;
                  });
                },
              ),
            ],
          ),
          gapH32,
          CartElevatedButton(
            isConfirm: true,
            customBgColor: AppColors.yellow,
            customFgColor: AppColors.black,
            customLabel: 'Checkout',
            customFunction: () {
              final totalPrice = product!.price * _quantity;

              final CartModel checkoutItem = ProductToCart(
                      productModel: product,
                      quantity: _quantity,
                      size: _selectedSize)
                  .getConvertedCart();

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CheckoutPage(
                      items: [checkoutItem], totalPrice: totalPrice)));
            },
          ),
        ],
      ),
    );
  }
}

class AddCartBottomSheet extends ConsumerStatefulWidget
    implements CartBottomSheet {
  const AddCartBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddCartBottomSheetState();
}

class _AddCartBottomSheetState extends ConsumerState<AddCartBottomSheet> {
  int _quantity = 1;
  String _selectedSize = 'M';
  final List<String> _sizes = ['S', 'M', 'L', 'XL'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Select Quantity and Size",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          gapH20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Quantity",
                style: TextStyle(fontSize: 16),
              ),
              gapW8,
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (_quantity > 1) _quantity--;
                      });
                    },
                  ),
                  Text(
                    '$_quantity',
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _quantity++;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          gapH20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Size",
                style: TextStyle(fontSize: 16),
              ),
              DropdownButton<String>(
                value: _selectedSize,
                items: _sizes.map((String size) {
                  return DropdownMenuItem<String>(
                    value: size,
                    child: Text(size),
                  );
                }).toList(),
                onChanged: (newSize) {
                  setState(() {
                    _selectedSize = newSize!;
                  });
                },
              ),
            ],
          ),
          gapH32,
          CartElevatedButton(
            isConfirm: true,
            customFunction: () async {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                    child: CircularProgressIndicator(
                  color: Colors.amber,
                )),
              );

              try {
                final productModel = ref.read(selectedProductProvider);

                final isProductAdded = await ref.read(
                  addToBagProvider(
                    productID: productModel!.id,
                    quantity: _quantity,
                    size: _selectedSize,
                  ).future,
                );
                // ignore: use_build_context_synchronously
                Navigator.of(context, rootNavigator: true).pop();

                if (isProductAdded && context.mounted) {
                  Navigator.pop(context);
                  SnackBarFailure(context,
                      message: "Successfully added to bag!");
                } else {
                  // ignore: use_build_context_synchronously
                  SnackBarFailure(context, message: "Failed to add to bag.");
                }
              } catch (e) {
                // ignore: use_build_context_synchronously
                SnackBarFailure(context, message: "Error to add to bag.");
              }
            },
          ),
        ],
      ),
    );
  }
}

class EditCartBottomSheet extends ConsumerStatefulWidget {
  final CartModel cartModel;

  const EditCartBottomSheet({
    super.key,
    required this.cartModel,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditCartBottomSheetState();
}

class _EditCartBottomSheetState extends ConsumerState<EditCartBottomSheet> {
  int _quantity = 1;
  String _selectedSize = 'M';
  final List<String> _sizes = ['S', 'M', 'L', 'XL'];

  @override
  void initState() {
    super.initState();
    _quantity = widget.cartModel.quantity;
    _selectedSize = widget.cartModel.size;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Select Quantity and Size",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          gapH20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Quantity",
                style: TextStyle(fontSize: 16),
              ),
              gapW8,
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (_quantity > 1) _quantity--;
                      });
                    },
                  ),
                  Text(
                    '$_quantity',
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _quantity++;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          gapH20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Size",
                style: TextStyle(fontSize: 16),
              ),
              DropdownButton<String>(
                value: _selectedSize,
                items: _sizes.map((String size) {
                  return DropdownMenuItem<String>(
                    value: size,
                    child: Text(size),
                  );
                }).toList(),
                onChanged: (newSize) {
                  setState(() {
                    _selectedSize = newSize!;
                  });
                },
              ),
            ],
          ),
          gapH32,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff292929),
                    foregroundColor: AppColors.yellow),
                child: const Text("Apply"),
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                        child: CircularProgressIndicator(
                      color: Colors.amber,
                    )),
                  );

                  if (_quantity == widget.cartModel.quantity &&
                      _selectedSize == widget.cartModel.size) {
                    Navigator.of(context, rootNavigator: true).pop();
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  } else {
                    final isProductModified = await ref.read(
                      editBagItemProvider(
                        cartID: widget.cartModel.cartID,
                        newQuantity: _quantity,
                        newSize: _selectedSize,
                      ).future,
                    );

                    // ignore: use_build_context_synchronously
                    Navigator.of(context, rootNavigator: true).pop();

                    if (isProductModified && context.mounted) {
                      Navigator.pop(context);
                      SnackBarFailure(context,
                          message: "Successfully modified!");
                    } else {
                      // ignore: use_build_context_synchronously
                      SnackBarFailure(context, message: "Failed to modify.");
                    }
                  }
                },
              ),
              const VerticalDivider(),
              ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                        child: CircularProgressIndicator(
                      color: Colors.amber,
                    )),
                  );

                  final isProductDeleted = await ref.read(
                      removeBagItemsProvider(cartIDs: [widget.cartModel.cartID])
                          .future);

                  // ignore: use_build_context_synchronously
                  Navigator.of(context, rootNavigator: true).pop();

                  if (isProductDeleted && context.mounted) {
                    Navigator.pop(context);
                    SnackBarFailure(context, message: "Successfully modified!");
                  } else {
                    // ignore: use_build_context_synchronously
                    SnackBarFailure(context, message: "Failed to modify.");
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
