import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/features/cart/data/cart_repository.dart';
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

  @override
  Widget build(BuildContext context) {
    bool isCartEmpty = true;
    final authState = ref.watch(authStateProvider);
    final cartItems = ref.watch(getBagItemsProvider);

    Widget buildAuthState() {
      return authState.when(
        data: (user) {
          if (user != null) {
            return cartItems.when(
              data: (item) {
                if (item.isNotEmpty) {
                  isCartEmpty = false;
                  totalPrices = item.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

                  return Column(
                    children: List.generate(
                      item.length,
                      (index) {
                        return ProductTile(
                          cartModel: item[index],
                          isEditing: isEditing, // Pass the editing state
                        );
                      },
                    ),
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

    return SingleChildScrollView(
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
              TextButton(
                onPressed: () {
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
                child: Text(
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
          const Divider(),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Total Amount",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          isCartEmpty
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CheckoutElevatedButton(),
                      ProductPriceBuilder(
                        price: totalPrices,
                        textStyle: const TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
          const SizedBox(height: 16),
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
    );
  }
}
