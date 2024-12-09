import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/core/utils/formats.dart';
import 'package:jbb_app_v5/features/cart/data/cart_repository.dart';
import 'package:jbb_app_v5/features/cart/model/cart_model.dart';
import 'package:jbb_app_v5/features/products/model/product_model.dart';
import 'package:jbb_app_v5/presentation/pages/home/home_screen.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_buttons.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_widget.dart';

abstract class CartBottomSheet {}

class BuyBottomSheet extends ConsumerStatefulWidget {
  const BuyBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BuyBottomSheetState();
}

class _BuyBottomSheetState extends ConsumerState<BuyBottomSheet> {
  int _quantity = 1;
  SizesModel? _selectedSize;
  double _subTotalPrice = 0.0;
  ProductModel? productModel;

  @override
  void initState() {
    productModel = ref.read(selectedProductProvider);
    _selectedSize = productModel!.sizes[0];
    setSubTotalPrice();
    super.initState();
  }

  void setSubTotalPrice() {
    double additional = _selectedSize!.additionalAmount;
    double basePrice = productModel!.price;

    _subTotalPrice = (basePrice + additional) * _quantity;
  }

  @override
  Widget build(BuildContext context) {
    // Ensure sizes are fetched from the ProductModel
    final List<SizesModel> availableSizes = productModel?.sizes ?? [];

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

                        setSubTotalPrice();
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

                        setSubTotalPrice();
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
              DropdownButton<SizesModel>(
                value: _selectedSize,
                items: availableSizes.map((SizesModel size) {
                  return DropdownMenuItem<SizesModel>(
                    value: size,
                    child: Text(size.size), // Display the size name
                  );
                }).toList(),
                onChanged: (newSize) {
                  setState(() {
                    _selectedSize = newSize!;

                    setSubTotalPrice();
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Additional Amount",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "+${currencyFormat(value: _selectedSize?.additionalAmount ?? 0.0)}",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          gapH32,
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "SubTotal",
                style: TextStyle(fontSize: 16),
              ),
              ProductPriceBuilder(
                price: _subTotalPrice,
                textStyle: const TextStyle(fontSize: 24),
              )
            ],
          ),
          gapH32,
          CartElevatedButton(
            isConfirm: true,
            customBgColor: AppColors.yellow,
            customFgColor: AppColors.black,
            customLabel: "Checkout",
            customFunction: () async {
              ref.read(bottomNavIndexProvider.notifier).state = 1;
              if (_selectedSize == null) {
                SnackBarFailure(context, message: "Please select a size.");
                return;
              }
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                    child: CircularProgressIndicator(
                  color: Colors.amber,
                )),
              );
              try {
                final isProductAdded = await ref.read(
                  addToBagProvider(
                    productID: productModel!.id,
                    quantity: _quantity,
                    size: _selectedSize!, // Use the selected size
                  ).future,
                );
                // ignore: use_build_context_synchronously
                Navigator.of(context, rootNavigator: true).pop();

                if (isProductAdded && context.mounted) { 
                  Navigator.pop(context);
                  SnackBarFailure(context,
                      message: "Successfully added to bag!");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {  
                          return HomeScreen();
                        },
                      ));
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

class AddCartBottomSheet extends ConsumerStatefulWidget
    implements CartBottomSheet {
  const AddCartBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddCartBottomSheetState();
}

class _AddCartBottomSheetState extends ConsumerState<AddCartBottomSheet> {
  int _quantity = 1;
  SizesModel? _selectedSize;
  double _subTotalPrice = 0.0;
  ProductModel? productModel;

  @override
  void initState() {
    productModel = ref.read(selectedProductProvider);
    _selectedSize = productModel!.sizes[0];
    setSubTotalPrice();
    super.initState();
  }

  void setSubTotalPrice() {
    double additional = _selectedSize!.additionalAmount;
    double basePrice = productModel!.price;

    _subTotalPrice = (basePrice + additional) * _quantity;
  }

  @override
  Widget build(BuildContext context) {
    // Ensure sizes are fetched from the ProductModel
    final List<SizesModel> availableSizes = productModel?.sizes ?? [];

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

                        setSubTotalPrice();
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

                        setSubTotalPrice();
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
              DropdownButton<SizesModel>(
                value: _selectedSize,
                items: availableSizes.map((SizesModel size) {
                  return DropdownMenuItem<SizesModel>(
                    value: size,
                    child: Text(size.size), // Display the size name
                  );
                }).toList(),
                onChanged: (newSize) {
                  setState(() {
                    _selectedSize = newSize!;

                    setSubTotalPrice();
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Additional Amount",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "+${currencyFormat(value: _selectedSize?.additionalAmount ?? 0.0)}",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          gapH32,
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "SubTotal",
                style: TextStyle(fontSize: 16),
              ),
              ProductPriceBuilder(
                price: _subTotalPrice,
                textStyle: const TextStyle(fontSize: 24),
              )
            ],
          ),
          gapH32,
          CartElevatedButton(
            isConfirm: true,
            customFunction: () async {
              if (_selectedSize == null) {
                SnackBarFailure(context, message: "Please select a size.");
                return;
              }
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                    child: CircularProgressIndicator(
                  color: Colors.amber,
                )),
              );
              try {
                final isProductAdded = await ref.read(
                  addToBagProvider(
                    productID: productModel!.id,
                    quantity: _quantity,
                    size: _selectedSize!, // Use the selected size
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
  SizesModel? _selectedSize;
  double _subTotalPrice = 0.0;

  @override
  void initState() {
    super.initState();

    // Ensure sizes list is not empty
    if (widget.cartModel.sizes.isNotEmpty) {
      _selectedSize = widget.cartModel.sizes.firstWhere(
        (size) => size.size == widget.cartModel.size.size,
        orElse: () => widget.cartModel.sizes.first,
      );
    }
    _quantity = widget.cartModel.quantity;
    setSubTotalPrice();
  }

  void setSubTotalPrice() {
    double additional = _selectedSize!.additionalAmount;
    double basePrice = widget.cartModel.price;

    _subTotalPrice = (basePrice + additional) * _quantity;
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

                        setSubTotalPrice();
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

                        setSubTotalPrice();
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
              DropdownButton<SizesModel>(
                value: _selectedSize,
                items: widget.cartModel.sizes.map((SizesModel size) {
                  return DropdownMenuItem<SizesModel>(
                    value: size,
                    child: Text(size.size), // Display the size name
                  );
                }).toList(),
                onChanged: (newSize) {
                  setState(() {
                    _selectedSize = newSize!;

                    setSubTotalPrice();
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Additional Amount",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "+${currencyFormat(value: _selectedSize?.additionalAmount ?? 0.0)}",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          gapH32,
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "SubTotal",
                style: TextStyle(fontSize: 16),
              ),
              ProductPriceBuilder(
                price: _subTotalPrice,
                textStyle: const TextStyle(fontSize: 24),
              )
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
                    bool isProductModified = false;
                    try {
                      isProductModified = await ref.read(
                        editBagItemProvider(
                          cartID: widget.cartModel.cartID,
                          newQuantity: _quantity,
                          newSize: _selectedSize!,
                        ).future,
                      );
                    } catch (e) {
                      isProductModified = false;
                    } finally {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context, rootNavigator: true).pop();

                      if (isProductModified && context.mounted) {
                        Navigator.pop(context);
                        SnackBarFailure(context,
                            message: "Successfully modified!");
                      } else {
                        // ignore: use_build_context_synchronously
                        SnackBarFailure(context, message: "No items modified.");
                      }
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
