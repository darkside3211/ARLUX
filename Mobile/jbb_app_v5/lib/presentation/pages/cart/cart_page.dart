import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/features/cart/data/cart_repository.dart';
import 'package:jbb_app_v5/features/cart/model/cart_model.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_buttons.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_card.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_grid.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_widget.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  bool isEditing = false;
  double totalPrices = 0.0;
  bool isSelectAll = false;
  List<bool> selectedItems = [];
  List<CartModel>? checkoutCart;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final cartItems = ref.watch(getBagItemsProvider);
    final subTotalPrices = ref.watch(subTotalPriceProvider);

    Widget buildAuthState() {
      return authState.when(
        data: (user) {
          if (user != null) {
            return cartItems.when(
              data: (item) {
                if (item.isNotEmpty) {
                  totalPrices = item.fold(
                      0.0, (sum, item) => sum + (item.price * item.quantity));

                  // Initialize selectedItems list based on item length
                  if (selectedItems.length != item.length) {
                    selectedItems = List<bool>.filled(item.length, false);
                  }

                  return Column(
                    children: [
                      //Display all cart items
                      Column(
                        children: List.generate(
                          item.length,
                          (index) {
                            return ProductTile(
                                cartModel: item[index],
                                isEditing: isEditing,
                                isSelected: selectedItems[index],
                                onSelected: (value) {
                                  setState(() {
                                    selectedItems[index] = value!;
                                    isSelectAll = selectedItems.every((e) => e);
                                    value
                                        ? ref
                                            .read(
                                                subTotalPriceProvider.notifier)
                                            .state += item[index]
                                                .price *
                                            item[index].quantity
                                        : ref
                                            .read(
                                                subTotalPriceProvider.notifier)
                                            .state -= item[index]
                                                .price *
                                            item[index].quantity;
                                  });
                                });
                          },
                        ),
                      ),
                    ],
                  );
                }
                return const Center(child: Text('Cart is empty'));
              },
              error: (err, stack) {
                return IconedFailure(
                    message: err.toString(),
                    displayIcon: const Icon(Icons.error));
              },
              loading: () => const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              ),
            );
          } else {
            return Center(
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.amber)),
                onPressed: () {
                  ref.read(bottomNavIndexProvider.notifier).state = 2;
                },
                child: Text(
                  'Login now',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            );
          }
        },
        error: (err, stack) => IconedFailure(
            message: err.toString(), displayIcon: const Icon(Icons.error)),
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: Colors.amber,
          ),
        ),
      );
    }

    void toggleSelectAll(bool? value) {
      setState(() {
        isSelectAll = value!;
        selectedItems = List<bool>.filled(selectedItems.length, isSelectAll);
        if (value) {
          ref.read(subTotalPriceProvider.notifier).state = 0;
        }
      });
    }

    Widget buildBottomMenu() {
      return Container(
        decoration: const BoxDecoration(
            border:
                Border(top: BorderSide(color: AppColors.yellow, width: 2.0))),
        child: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.yellow,
                      checkColor: AppColors.black,
                      value: isSelectAll,
                      onChanged: (value) {
                        toggleSelectAll(value);
                      },
                    ),
                    const Text('All'),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Total:",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                  ProductPriceBuilder(
                      price: isSelectAll ? totalPrices.abs() : subTotalPrices.abs()),
                ],
              ),
              gapW16,
              const BuyElevatedButton(),
            ],
          ),
        ),
      );
    }

    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shopping Bag Title and Edit Button Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.shopping_bag_rounded,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "Shopping Bag",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  // Edit Button
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        isEditing = !isEditing;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.black),
                    label: Icon(
                      Icons.sort,
                      color: isEditing ? Colors.red : Colors.amber,
                    ),
                    icon: Text(
                      isEditing ? 'Done' : 'Edit',
                      style: TextStyle(
                        color: isEditing ? Colors.red : Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              buildAuthState(),
              const SizedBox(height: 8),
              const Divider(height: 32),
              const SizedBox(height: 16),
              Text(
                "Browse for More",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const ProductListImpl(isScrollable: false),
            ],
          ),
        ),
        if (isEditing)
          Align(
            alignment: Alignment.bottomCenter,
            child: buildBottomMenu(),
          )
      ],
    );
  }
}
