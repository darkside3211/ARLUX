import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jbb_app_v2/core/constants/constants.dart';
import 'package:jbb_app_v2/features/product_list/model/product_model.dart';
import 'package:jbb_app_v2/features/product_list/presentation/widgets/app_bars.dart';
import 'package:jbb_app_v2/features/product_list/presentation/widgets/icon_widgets.dart';
import 'package:jbb_app_v2/features/product_list/presentation/widgets/filter_panel.dart';
import 'package:jbb_app_v2/features/product_list/presentation/widgets/product_cards.dart';
import 'package:jbb_app_v2/features/product_list/provider/product_provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProductsListPage extends ConsumerStatefulWidget {
  final String? category;
  final int? limited;
  final String? sorted;
  const ProductsListPage({super.key, this.category, this.limited, this.sorted});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductsListPageState();
}

class _ProductsListPageState extends ConsumerState<ProductsListPage> {
  final PanelController panelController = PanelController();

  void togglePanel() {
    panelController.isPanelOpen
        ? panelController.close()
        : panelController.open();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<ProductModel>> productList = ref.watch(
        getProductListProvider(
            category: widget.category,
            limited: widget.limited,
            sorted: widget.sorted));

    final minPanelHeight = getScreenHeight(context) * 0;
    final maxPanelHeight = getScreenHeight(context) * 0.5;

    return Scaffold(
      appBar: searchBar(context, togglePanel),
      body: SlidingUpPanel(
        defaultPanelState: PanelState.CLOSED,
        controller: panelController,
        color: isDark(context) ? Theme.of(context).cardColor : Colors.white,
        backdropEnabled: true,
        minHeight: minPanelHeight,
        maxHeight: maxPanelHeight,
        panelBuilder: (scrollController) => FilterPanel(
          scrollController: scrollController,
          panelController: panelController,
        ),
        body: productList.when(data: (data) {
          if (data.isNotEmpty) {
            return MasonryGridView.builder(
              padding: const EdgeInsets.all(8),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ProductCards(productModel: data[index]);
              },
            );
          } else {
            return showIconError(
                symbol: const Icon(Icons.cloud_off_sharp),
                message: 'No results found.');
          }
        }, error: (error, stackTrace) {
          return showIconError(
              symbol: const Icon(
                Icons.error,
                size: 64,
              ),
              message: error.toString());
        }, loading: () {
          return showIconError(
              symbol: const CircularProgressIndicator(), message: 'Loading...');
        }),
      ),
    );
  }
}
