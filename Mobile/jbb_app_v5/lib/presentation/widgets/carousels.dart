import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/core/constants/filter_values.dart';
import 'package:jbb_app_v5/features/products/data/product_remote_repository.dart';
import 'package:jbb_app_v5/features/products/model/product_model.dart';
import 'package:jbb_app_v5/features/products/model/search_product_model.dart';
import 'package:jbb_app_v5/presentation/pages/home/product_listing.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_card.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_grid.dart';

abstract class Carousels {}

class ProductCategoryCarousel extends StatelessWidget implements Carousels {
  ProductCategoryCarousel({super.key});

  final List<String> categoryList = ['All'];

  @override
  Widget build(BuildContext context) {
    categoryList.addAll(jewelryCategories);

    return SizedBox(
      height: 128,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 128,
            child: Card(
              color: Colors.amber.shade50,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        if (index == 0) {
                          return const ProductListing(
                            productGrid: ProductListImpl(isScrollable: true),
                          );
                        }

                        return ProductListing(
                          productGrid: ProductCategorizedImpl(
                              category: categoryList[index],
                              isScrollable: true),
                        );
                      },
                    ),
                  );
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

class ProductFeaturedCarousel extends ConsumerWidget {
  const ProductFeaturedCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<SearchProductModel> searchResult =
        ref.watch(searchProductListProvider(q: 'Moissanite Heart Evil'));
    return SizedBox(
      height: 294,
      child: searchResult.when(
        data: (data) {
          final List<ProductModel> productList = data.results;

          if (productList.isNotEmpty) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 200,
                  child: ProductFeatureCard(productModel: productList[index]),
                );
              },
            );
          }
          return const IconedFailure(
            message: 'No Featured Products to Shown',
            displayIcon: Icon(
              Icons.error,
            ),
          );
        },
        error: (err, stack) {
          return IconedFailure(
            message: err.toString(),
            displayIcon: const Icon(Icons.error),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: Colors.amber),
        ),
      ),
    );
  }
}
