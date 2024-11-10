import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/presentation/pages/order/order_page.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_image.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_grid.dart';

class CheckoutResult extends ConsumerWidget {
  const CheckoutResult({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.amber),
        titleTextStyle: const TextStyle(
            color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 18),
        backgroundColor: const Color(0xff292929),
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: const Color(0xff292929),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 128,
                      child: CustomSingleImage(
                          image: 'assets/icons/jbb_logo.png',
                          disableGestures: true,
                          aspectRatio: 1),
                    ),
                    const Text(
                      'Thank you for Purchasing!',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: AppColors.yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    gapH24,
                    const Text(
                      'Your Order is Placed',
                      style: TextStyle(
                        color: AppColors.yellow,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(bottomNavIndexProvider.notifier).state = 2;
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const OrderPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.yellow,
                          foregroundColor: const Color(0xff292929)),
                      child: const Text('Check your Order'),
                    ),
                    gapH4,
                  ],
                ),
              ),
            ),
            gapH8,
            const Text(
              '\tBrowse for More!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Divider(),
            const ProductListImpl(isScrollable: false),
          ],
        ),
      ),
    );
  }
}
