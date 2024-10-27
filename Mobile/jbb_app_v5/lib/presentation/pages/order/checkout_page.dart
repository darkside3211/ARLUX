import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/core/network/network_core.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/features/cart/data/cart_repository.dart';
import 'package:jbb_app_v5/features/cart/model/cart_model.dart';
import 'package:jbb_app_v5/features/order/data/order_repository.dart';
import 'package:jbb_app_v5/features/order/model/order_model.dart';
import 'package:jbb_app_v5/presentation/pages/order/address_selection.dart';
import 'package:jbb_app_v5/presentation/pages/order/checkout_result.dart';
import 'package:jbb_app_v5/presentation/providers/cart_to_product.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_card.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_widget.dart';

class CheckoutPage extends ConsumerStatefulWidget {
  final List<CartModel> items;
  final double totalPrice;
  const CheckoutPage({
    super.key,
    required this.items,
    required this.totalPrice,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> key = GlobalKey();
    final user = ref.watch(getUserInfoProvider);
    final address = ref.watch(defaultAddressProvider);

    Widget buildTiles() {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return ProductTile(
            cartModel: widget.items[index],
            isDefault: false,
            value: true,
            onChanged: (value) {},
          );
        },
      );
    }

    return Scaffold(
      key: key,
      endDrawer: const AddressSelection(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.amber),
        titleTextStyle: const TextStyle(
            color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 18),
        backgroundColor: const Color(0xff292929),
        title: const Text('Checkout'),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border:
                Border(top: BorderSide(color: AppColors.yellow, width: 2.0))),
        child: BottomAppBar(
          padding: const EdgeInsets.all(0),
          color: AppColors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Total'),
                  ProductPriceBuilder(price: widget.totalPrice),
                ],
              ),
              gapW16,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.yellow,
                    fixedSize: const Size.fromHeight(80.0),
                    shape: const BeveledRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.zero,
                    )),
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                        child: CircularProgressIndicator(
                      color: Colors.amber,
                    )),
                  );

                  List<CheckoutItem> orders = [];
                  List<String> cartIDs = [];

                  for (var item in widget.items) {
                    cartIDs.add(item.cartID);
                    orders.add(
                        CartToCheckout(cartModel: item).getConvertedItem());
                  }

                  final checkout = await ref.read(
                      checkoutOrderProvider(address: address!, orders: orders)
                          .future);

                  if (checkout != null) {
                    LaunchCheckout(checkoutUrl: checkout);

                    final clearCheckouts = await ref
                        .read(removeBagItemsProvider(cartIDs: cartIDs).future);

                    if (clearCheckouts && context.mounted) {
                      Navigator.of(context, rootNavigator: true).pop();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const CheckoutResult(),
                        ),
                      );
                    }
                  } else if (checkout == null && context.mounted) {
                    Navigator.of(context, rootNavigator: true).pop();
                    SnackBarFailure(context, message: 'An Error Occured');
                  }
                },
                child: const Text(
                  'Place Order',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: user.when(
        data: (data) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(thickness: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Billing Information',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(),
                ListTile(
                  onTap: () {
                    key.currentState!.openEndDrawer();
                  },
                  leading: const Icon(
                    Icons.location_on,
                    color: Colors.amber,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  title: Text(
                    '${data.username} (${address!.addressLabel})',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${address.line1} | ${address.city} | ${address.state} | ${address.country} : ${address.postal_code}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text('${data.phone}')
                    ],
                  ),
                  dense: true,
                  isThreeLine: true,
                ),
                const Divider(thickness: 8),
                gapH16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'List Items (${widget.items.length})',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(),
                buildTiles(),
                const Divider(thickness: 8),
                gapH16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Checkout Details',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shipping Provider',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                'LBC ',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              SizedBox(
                                height: 24,
                                child: Image.asset(
                                  'assets/icons/lbc_logo.png',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      gapH8,
                      Row(
                        children: [
                          Text(
                            'Payment Option',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 24,
                            child: Image.asset(
                              'assets/icons/paymongo_logo.png',
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              SizedBox(
                                height: 24,
                                child: Image.asset(
                                  'assets/icons/gcash_logo.png',
                                ),
                              ),
                              const Text(' | '),
                              SizedBox(
                                height: 24,
                                child: Image.asset(
                                  'assets/icons/paymaya_logo.png',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      gapH8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery Fee',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Amount will be set after order is placed.',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                      gapH8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Items',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'x${widget.items.fold(0, (sum, item) => sum + item.quantity)}',
                            style: Theme.of(context).textTheme.bodySmall!,
                          ),
                        ],
                      ),
                      gapH8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Payment',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          ProductPriceBuilder(
                            price: widget.totalPrice,
                            textStyle: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      gapH8,
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        error: (err, stack) {
          return IconedFailure(
              message: err.toString(),
              displayIcon: const Icon(Icons.wifi_off));
        },
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
