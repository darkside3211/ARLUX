import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v4/core/constants/app_sizes.dart';
import 'package:jbb_app_v4/features/jewelry/presentation/app_bars/jewelry_search_field.dart';
import 'package:jbb_app_v4/features/jewelry/presentation/jewelry_list/jewelry_carousels.dart';
import 'package:jbb_app_v4/features/jewelry/presentation/jewelry_list/jewelry_grid.dart';
import 'package:jbb_app_v4/features/jewelry/presentation/jewelry_screen/jewelry_list_result.dart';

class JewerlyHome extends ConsumerStatefulWidget {
  const JewerlyHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JewerlyHomeState();
}

class _JewerlyHomeState extends ConsumerState<JewerlyHome> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gapH16,
          const JewelrySearchField(),
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
                    builder: (context) => const JewelryListResult(
                        gridItems: JewelryListsImpl(isScrollable: true)),
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
          JewelryCategoryCarousel(),
          gapH32,
          Text(
            "Featured Products",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          gapH8,
          const JewelryFeaturedCarousel(),
          const Divider(),
          gapH16,
          Text(
            "Find Your Taste",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          gapH8,
          const JewelryListsImpl(isScrollable: false),
        ],
      ),
    );
  }
}
