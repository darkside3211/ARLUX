import 'package:flutter/material.dart';
import 'package:jbb_app_v4/core/constants/app_sizes.dart';
import 'package:jbb_app_v4/core/constants/filter_values.dart';
import 'package:jbb_app_v4/core/constants/tests.dart';
import 'package:jbb_app_v4/features/jewelry/presentation/jewelry_list/jewelry_card.dart';
import 'package:jbb_app_v4/features/jewelry/presentation/jewelry_list/jewelry_grid.dart';
import 'package:jbb_app_v4/features/jewelry/presentation/jewelry_screen/jewelry_list_result.dart';

abstract class JewelryCarousels {}

class JewelryCategoryCarousel extends StatelessWidget
    implements JewelryCarousels {
  JewelryCategoryCarousel({super.key});

  final List<String> categoryList = ["All"];

  @override
  Widget build(BuildContext context) {
    categoryList.addAll(jewelryCategories);
    int startColor = 600;
    return SizedBox(
      height: 120.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          startColor -= 100;
          return SizedBox(
            width: 128,
            child: Card(
              color: Colors.amber[startColor],
              child: InkWell(
                onTap: () {
                  if (index == 0) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const JewelryListResult(
                                gridItems: JewelryListsImpl(
                              isScrollable: true,
                            ))));
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => JewelryListResult(
                          gridItems: CategorizeJewelryListImpl(
                              isScrollable: true,
                              category: categoryList[index]),
                        ),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.p16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_bag,
                        size: Sizes.p32,
                      ),
                      gapH8,
                      Text(
                        categoryList[index],
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const VerticalDivider(),
      ),
    );
  }
}

class JewelryFeaturedCarousel extends StatelessWidget
    implements JewelryCarousels {
  const JewelryFeaturedCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    int startColor = 100;
    return SizedBox(
      height: 330,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: jewelryFeatured.length,
        itemBuilder: (context, index) {
          startColor += 100;
          return SizedBox(
            width: 200,
            child: JewelryCard(
              jewelryModel: jewelryFeatured[index],
              cardColor: Colors.yellow[startColor],
            ),
          );
        },
      ),
    );
  }
}
