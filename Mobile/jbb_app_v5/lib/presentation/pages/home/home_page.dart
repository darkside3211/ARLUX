import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/presentation/pages/home/ad_carousel.dart';
import 'package:jbb_app_v5/presentation/search/search_page.dart';
import 'package:jbb_app_v5/presentation/widgets/carousels.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_grid.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapH24,
              const AdCarousel(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Discover exquisite jewelry pieces that tell your unique story.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
              gapH8,
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
        ),
        Align(
          alignment: Alignment.topCenter,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SearchPage()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 48,
              decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: AppColors.black),
                    bottom: BorderSide(color: AppColors.yellow)),
                color: Color(0xff292929),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.amber,
                  ),
                  gapW16,
                  Text(
                    'Search By Product, Category & More...',
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
