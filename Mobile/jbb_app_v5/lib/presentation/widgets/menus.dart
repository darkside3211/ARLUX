import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/core/constants/filter_values.dart';
import 'package:jbb_app_v5/core/network/network_core.dart';
import 'package:jbb_app_v5/features/products/data/product_remote_repository.dart';
import 'package:jbb_app_v5/presentation/pages/home/product_listing.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_buttons.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_grid.dart';

abstract class Menus {}

class HomeMenuDrawer extends StatelessWidget {
  const HomeMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff292929),
            ),
            child: Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Host Address'),
            onTap: () {
              Navigator.of(context).pop();
              _showHostAddressDialog(context);
            },
          ),
          const ThemeToggleButton(),
        ],
      ),
    );
  }

  void _showHostAddressDialog(BuildContext context) {
    final TextEditingController ipController = TextEditingController();
    final TextEditingController portController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Set Host Address',
            style: TextStyle(color: Colors.black),
          ),
          content: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: ipController,
                  decoration: const InputDecoration(
                    hintText: 'IP Address',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: portController,
                  decoration: const InputDecoration(
                    hintText: 'Port',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.amber),
              ),
              onPressed: () {
                String ipAddress = ipController.text.trim();
                String portAddress = portController.text.trim();

                if (ipAddress.isEmpty || portAddress.isEmpty) {
                  SnackBarFailure(context,
                      message: 'Please enter both IP and Port');
                  return;
                }

                try {
                  int parsedPort = int.parse(portAddress);
                  if (parsedPort <= 0 || parsedPort > 65535) {
                    SnackBarFailure(context,
                        message:
                            'Invalid port number. Must be between 1 and 65535');
                    return;
                  }
                } catch (e) {
                  SnackBarFailure(context,
                      message: 'Invalid port number. Must be a number');
                  return;
                }

                HostAddress.setValue(newIp: ipAddress, newPort: portAddress);
                Navigator.of(context).pop();
                SnackBarFailure(context,
                    message: 'Host address updated successfully');
              },
            ),
          ],
        );
      },
    );
  }
}

class FilterDrawer extends ConsumerWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchQueryProvider);
    final filterState = ref.watch(filterStateProvider);
    final filterNotifier = ref.read(filterStateProvider.notifier);

    final TextEditingController minPriceController =
        TextEditingController(text: filterState.minPrice.toString());
    final TextEditingController maxPriceController = TextEditingController(
        text: filterState.maxPrice == double.infinity
            ? ''
            : filterState.maxPrice.toString());

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
              color: Colors.amber,
            ),
            child: Text(
              'Filter Options',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          ),
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
          gapH20,
          // Category Dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButtonFormField<String>(
              value: filterState.category,
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
                filterNotifier.state = filterState.copyWith(category: newValue);
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

                filterNotifier.state = filterState.copyWith(
                  minPrice: minPrice,
                  maxPrice: maxPrice,
                );

                // ignore: unused_result
                ref.refresh(
                  searchProductListProvider(
                    q: searchState,
                    category: filterState.category,
                    minPrice: filterState.minPrice,
                    maxPrice: filterState.maxPrice,
                  ),
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductListing(
                      productGrid: ProductSearchImpl(
                        q: searchState,
                        category: filterState.category,
                        minPrice: filterState.minPrice,
                        maxPrice: filterState.maxPrice,
                        isScrollable: true,
                      ),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, foregroundColor: Colors.amber),
              child: const Text('Apply Filters'),
            ),
          ),
        ],
      ),
    );
  }
}
