import 'package:flutter/material.dart';
import 'package:jbb_app_v5/presentation/widgets/app_bars.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_grid.dart';

class ProductListing extends StatelessWidget {
  final ProductGrid productGrid;
  final String? queryText;

  const ProductListing({super.key, required this.productGrid, this.queryText});

  @override
  Widget build(BuildContext context) {
    String searchQuery = queryText ?? '';

    return Scaffold(
      appBar: ProductListTopBar(searchedText: searchQuery),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: productGrid,
        ),
      ),
    );
  }
}
