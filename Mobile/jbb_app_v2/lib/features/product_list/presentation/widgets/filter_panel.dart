import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jbb_app_v2/core/constants/constants.dart';
import 'package:jbb_app_v2/features/product_list/presentation/pages/products_list_page.dart';
import 'package:jbb_app_v2/features/product_list/presentation/widgets/icon_widgets.dart';
import 'package:jbb_app_v2/features/product_list/provider/product_provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FilterPanel extends ConsumerStatefulWidget {
  final PanelController panelController;
  final ScrollController scrollController;
  const FilterPanel({
    super.key,
    required this.scrollController,
    required this.panelController,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilterPanelState();
}

class _FilterPanelState extends ConsumerState<FilterPanel> {
  int? selectedLimit;
  String? selectedSort;
  String? selectedCategory;

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<dynamic>> categoryList =
        ref.watch(getCategoryListProvider);

    return categoryList.when(
      data: (data) {
        if (data.isNotEmpty) {
          return PopScope(
            canPop: widget.panelController.isPanelClosed,
            onPopInvoked: (didPop) {
              widget.panelController.close();
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      DropdownMenu<int>(
                        label: const Text('Limit'),
                        initialSelection: selectedLimit,
                        dropdownMenuEntries: filterLimitItems,
                        onSelected: (int? newLimit) {
                          setState(() {
                            selectedLimit = newLimit;
                          });
                        },
                      ),
                      const SizedBox(width: 16),
                      DropdownMenu<String>(
                        label: const Text('Sort'),
                        initialSelection: selectedSort,
                        dropdownMenuEntries: filterSortItems,
                        onSelected: (String? newSort) {
                          setState(() {
                            selectedSort = newSort;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: MasonryGridView.builder(
                    controller: widget.scrollController,
                    padding: const EdgeInsets.all(8),
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) => Card(
                      child: ListTile(
                        selected: selectedIndex == index,
                        selectedTileColor: Colors.amber,
                        title: Text(
                          data[index].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: isDark(context)
                                  ? selectedIndex == index
                                      ? Colors.black
                                      : Colors.white
                                  : Colors.black),
                        ),
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            selectedCategory = data[index].toString();
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        widget.panelController.close();
                      },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedCategory != null) {
                          filterProducts();
                        } else {
                          widget.panelController.close();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: const Color(0xff292929)),
                      child: const Text('Confirm'),
                    ),
                    const SizedBox(height: 24),
                  ],
                )
              ],
            ),
          );
        } else {
          return showIconError(
              symbol: const Icon(Icons.cloud_off),
              message: 'No results found.');
        }
      },
      error: (error, stackTrace) {
        return showIconError(
            symbol: const Icon(Icons.error), message: error.toString());
      },
      loading: () => showIconError(
          symbol: const CircularProgressIndicator(), message: 'Loading...'),
    );
  }

  void filterProducts() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return ProductsListPage(
          category: selectedCategory,
          limited: selectedLimit,
          sorted: selectedSort,
        );
      },
    ));
  }
}
