import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/features/products/data/product_remote_repository.dart';
import 'package:jbb_app_v5/features/products/model/product_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jbb_app_v5/features/products/model/search_product_model.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_card.dart';

abstract class ProductGrid extends Widget {
  final bool isScrollable;

  const ProductGrid({super.key, required this.isScrollable});
}

class ProductListImpl extends ConsumerWidget implements ProductGrid {
  @override
  final bool isScrollable;

  const ProductListImpl({super.key, required this.isScrollable});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<ProductModel>> productList =
        ref.watch(fetchProductListProvider);

    return productList.when(
        data: (data) {
          if (data.isNotEmpty) {
            return MasonryGridView.builder(
              shrinkWrap: !isScrollable,
              physics: isScrollable
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
              itemCount: data.length,
              itemBuilder: (context, index) => ProductThumbnail(
                productModel: data[index],
              ),
            );
          }

          return const IconedFailure(
              message: 'Products Empty', displayIcon: Icon(Icons.cloud_off));
        },
        error: (err, stack) => IconedFailure(
            message: err.toString(), displayIcon: const Icon(Icons.error)),
        loading: () => const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            ));
  }
}

class ProductSearchImpl extends ConsumerWidget implements ProductGrid {
  @override
  final bool isScrollable;
  final bool isRecommendation;
  final String q;
  final String? category;
  final double? minPrice;
  final double? maxPrice;

  const ProductSearchImpl({
    super.key,
    required this.q,
    required this.isScrollable,
    this.isRecommendation = false,
    this.category,
    this.minPrice,
    this.maxPrice,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<SearchProductModel> searchResults = ref.watch(
      searchProductListProvider(
        q: q,
        category: category,
        minPrice: minPrice,
        maxPrice: maxPrice,
      ),
    );

    return searchResults.when(
      data: (data) {
        final List<ProductModel> productList = data.results;

        if (productList.isNotEmpty) {
          return MasonryGridView.builder(
            shrinkWrap: !isScrollable,
            physics: isScrollable
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount:isRecommendation ? productList.length - 1 : productList.length,
            itemBuilder: (context, index) {
              if (isRecommendation) {
                return ProductThumbnail(productModel: productList[index + 1]);
              } else {
                return ProductThumbnail(productModel: productList[index]);
              }
            }
          );
        }

        return const IconedFailure(
          message: 'No Products Found.',
          displayIcon: Icon(Icons.error),
        );
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
}

class ProductCategorizedImpl extends ConsumerWidget implements ProductGrid {
  @override
  final bool isScrollable;

  final String category;

  const ProductCategorizedImpl({
    super.key,
    required this.category,
    required this.isScrollable,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<ProductModel>> productList =
        ref.watch(categorizeProductListProvider(category: category));
    return productList.when(
      data: (data) {
        if (data.isNotEmpty) {
          return MasonryGridView.builder(
            shrinkWrap: !isScrollable,
            physics: isScrollable
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: data.length,
            itemBuilder: (context, index) => ProductThumbnail(
              productModel: data[index],
            ),
          );
        }

        return const IconedFailure(
            message: 'Products Empty', displayIcon: Icon(Icons.cloud_off));
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
}


