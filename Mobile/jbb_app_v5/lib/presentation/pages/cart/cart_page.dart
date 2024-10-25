import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/features/cart/data/cart_repository.dart';
import 'package:jbb_app_v5/features/cart/model/cart_model.dart';
import 'package:jbb_app_v5/presentation/pages/cart/cart_bottom_sheet.dart';
import 'package:jbb_app_v5/presentation/pages/order/checkout_page.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:jbb_app_v5/presentation/widgets/no_user.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_card.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_grid.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_widget.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  List<CartModel> selectedBag = [];
  bool isSelectAll = false;

  double totalPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final bagItems = ref.watch(getBagItemsProvider);

    void toggleSelectAll(List<CartModel> items) {
      setState(() {
        if (isSelectAll) {
          // Unselect all items
          selectedBag.clear();
          totalPrice = 0.0;
        } else {
          // Select all items
          selectedBag = List.from(items); // Add all items to selectedBag
          totalPrice =
              items.fold(0.0, (sum, item) => sum + item.price * item.quantity);
        }
        isSelectAll = !isSelectAll; // Toggle isSelectAll
      });
    }

    void showEditCartSheet(BuildContext context, CartModel cartModel) {
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
                cartModel: cartModel), // Content inside the bottom sheet
          );
        },
      );
    }

    Widget buildBags() {
      return bagItems.when(
        data: (item) {
          if (item.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: item.length,
              itemBuilder: (context, index) {
                final cartItem = item[index];
                final isSelected = selectedBag.contains(cartItem);

                return InkWell(
                  onLongPress: () {
                    setState(() {
                      isSelectAll = false;
                      totalPrice = 0.0;
                      selectedBag.clear();
                    });
                    return showEditCartSheet(context, cartItem);
                  },
                  onTap: () {
                    setState(() {
                      isSelectAll = false;
                      totalPrice = 0.0;
                      selectedBag.clear();
                    });
                    return showEditCartSheet(context, cartItem);
                  },
                  child: ProductTile(
                      cartModel: cartItem,
                      value: isSelected,
                      onChanged: (value) {
                        if (value == true) {
                          setState(() {
                            totalPrice +=
                                item[index].price * item[index].quantity;
                            selectedBag.add(item[index]);
                          });
                        } else {
                          setState(() {
                            totalPrice -=
                                item[index].price * item[index].quantity;
                            selectedBag.remove(item[index]);
                          });
                        }

                        isSelectAll = selectedBag.length == item.length;
                      }),
                );
              },
            );
          } else {
            return const IconedFailure(
              message: 'You bag is empty...',
              displayIcon: Icon(Icons.remove_shopping_cart_outlined),
            );
          }
        },
        error: (err, stack) => const IconedFailure(
          message: 'Failed to get cart items. Try again...',
          displayIcon: Icon(Icons.remove_shopping_cart_outlined),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: Colors.amber,
          ),
        ),
      );
    }

    return authState.when(
      data: (user) {
        if (user != null) {
          return Scaffold(
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(color: AppColors.yellow, width: 2.0))),
              child: BottomAppBar(
                padding: const EdgeInsets.all(0),
                elevation: 2,
                color: AppColors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Checkbox(
                          activeColor: AppColors.yellow,
                          checkColor: AppColors.black,
                          value: isSelectAll,
                          onChanged: (value) {
                            final List<CartModel> bagItemData =
                                bagItems.maybeWhen(
                                    data: (items) => items, orElse: () => []);
                            toggleSelectAll(bagItemData);
                          },
                        ),
                        const Text('Select All'),
                      ],
                    ),
                    const Spacer(),
                    ProductPriceBuilder(price: totalPrice.abs()),
                    gapW16,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.yellow,
                          fixedSize: const Size.fromHeight(80.0),
                          shape: const BeveledRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.zero,
                          )),
                      onPressed: () {
                        if (selectedBag.isNotEmpty) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return CheckoutPage(
                                  items: selectedBag,
                                  totalPrice: totalPrice,
                                );
                              },
                            ),
                          );
                        } else {
                          SnackBarFailure(context,
                              message: 'Item selections are empty.');
                        }
                      },
                      child: Text(
                        'Checkout (${selectedBag.length})',
                        style: const TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: Column(
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
                    const Divider(),
                    buildBags(),
                    gapH16,
                    Text(
                      "Browse for More",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    const ProductListImpl(isScrollable: false),
                  ],
                )),
          );
        } else {
          return const NoUser(
              title: 'Shopping Bag', icon: Icons.remove_shopping_cart);
        }
      },
      error: (err, stack) => const IconedFailure(
          message: 'You seem to be offline.',
          displayIcon: Icon(Icons.wifi_off)),
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: Colors.amber,
        ),
      ),
    );
  }
}
