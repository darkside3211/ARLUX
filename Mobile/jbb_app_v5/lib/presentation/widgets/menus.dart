import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/core/constants/filter_values.dart';
import 'package:jbb_app_v5/features/search/model/search_model.dart';
import 'package:jbb_app_v5/presentation/pages/home/product_listing.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_grid.dart';

abstract class Menus {}

class FilterDrawer extends ConsumerWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchQueryProvider);
    final categoryState = ref.watch(categoryQueryProvider);
    final minPriceState = ref.watch(minPriceQueryProvider);
    final maxPriceState = ref.watch(maxPriceQueryProvider);

    final TextEditingController minPriceController =
        TextEditingController(text: minPriceState.toString());
    final TextEditingController maxPriceController = TextEditingController(
        text: maxPriceState == double.infinity ? '' : maxPriceState.toString());

    // Example categories list (can be replaced with actual categories)
    final List<String> categories = [
      'All',
    ];

    categories.addAll(jewelryCategories);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff292929),
            ),
            child: Text(
              'Filter Options',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Price Range:',
              style: TextStyle(fontSize: 18),
            ),
          ),
          gapH8,
          // Min and Max Price in a Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                // Min Price TextField
                Expanded(
                  child: TextField(
                    controller: minPriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Min Price',
                      hintText: 'Min',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                  child: Divider(),
                ),
                // Max Price TextField
                Expanded(
                  child: TextField(
                    controller: maxPriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Max Price',
                      hintText: 'Max',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          gapH20,
          // Category Dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButtonFormField<String>(
              value: categoryState,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                ref.read(categoryQueryProvider.notifier).state =
                    newValue ?? 'All';
              },
            ),
          ),
          gapH20,
          // Apply Filters Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Implement filter logic here
                final minPrice =
                    double.tryParse(minPriceController.text) ?? 0.0;
                final maxPrice =
                    double.tryParse(maxPriceController.text) ?? double.infinity;

                ref.read(minPriceQueryProvider.notifier).state = minPrice;
                ref.read(maxPriceQueryProvider.notifier).state = maxPrice;

                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductListing(
                      productGrid: ProductSearchImpl(
                        q: searchState,
                        category: categoryState,
                        minPrice: minPriceState,
                        maxPrice: maxPriceState,
                        isScrollable: true,
                      ),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: AppColors.yellow),
              child: const Text('Apply Filters'),
            ),
          ),
        ],
      ),
    );
  }
}
