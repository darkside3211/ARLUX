import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/presentation/pages/home/product_listing.dart';
import 'package:jbb_app_v5/presentation/widgets/carousels.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_grid.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_search_field.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gapH16,
          const ProductSearchField(),
          gapH16,
          Center(
            child: Text(
              "Discover exquisite jewelry pieces that tell your unique story.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
          ),
          gapH4,
          Center(
            child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.amber)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProductListing(
                        productGrid: ProductListImpl(isScrollable: true)),
                  ));
                },
                child: Text(
                  'Shop Now',
                  style: Theme.of(context).textTheme.titleMedium,
                )),
          ),
          const Divider(),
          Text(
            "Categories",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          gapH4,
          ProductCategoryCarousel(),
          gapH32,
          Text(
            "Featured Products",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          gapH8,
          const ProductFeaturedCarousel(),
          const Divider(height: 32),
          Text(
            "Find Your Taste",
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
