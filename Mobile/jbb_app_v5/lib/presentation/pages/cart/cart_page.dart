import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/features/cart/data/cart_repository.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_buttons.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_card.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_grid.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_widget.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isCartEmpty = true;
    double totalPrices = 0.0;
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
                  return Column(
                    children: List.generate(
                      item.length,
                      (index) {
                        final double productPrice =
                            item[index].price *
                                item[index].quantity;

                        totalPrices += productPrice;

                        return ProductTile(
                          cartModel: item[index],
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
          Row(
            children: [
              const Icon(
                Icons.shopping_bag_rounded,
                color: Colors.amber,
              ),
              gapW16,
              Text(
                "Shopping Bag",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          gapH16,
          buildAuthState(),
          gapH8,
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
          gapH16,
          const Divider(height: 32),
          gapH16,
          Text(
            "Browse for More",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          gapH8,
          const ProductListImpl(isScrollable: false),
        ],
      ),
    );
  }
}
