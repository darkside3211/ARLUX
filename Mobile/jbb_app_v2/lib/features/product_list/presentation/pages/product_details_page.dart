import 'package:flutter/material.dart';
import 'package:jbb_app_v2/core/constants/constants.dart';
import 'package:jbb_app_v2/features/product_list/model/product_model.dart';
import 'package:jbb_app_v2/features/product_list/presentation/widgets/app_bars.dart';
import 'package:jbb_app_v2/features/product_list/presentation/widgets/bottom_bars.dart.dart';
import 'package:jbb_app_v2/features/product_list/presentation/widgets/product_details_panel.dart';
import 'package:jbb_app_v2/features/product_list/presentation/widgets/product_viewer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel productModel;

  const ProductDetailsPage({
    super.key,
    required this.productModel,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late PanelController panelController;


  @override
  void initState() {
    super.initState();
    panelController = PanelController();
  }

  @override
  Widget build(BuildContext context) {
    final minPanelHeight = getScreenHeight(context) * 0.26;
    final maxPanelHeight = getScreenHeight(context) * 0.5;

    return Material(
      child: Scaffold(
        appBar: productDetailBar(context),
        body: SlidingUpPanel(
          color: isDark(context) ? Theme.of(context).cardColor : Theme.of(context).cardColor,
          controller: panelController,
          defaultPanelState: PanelState.CLOSED,
          minHeight: minPanelHeight,
          maxHeight: maxPanelHeight,
          parallaxEnabled: true,
          parallaxOffset: 0.8,
          padding: const EdgeInsets.only(left: 10, right: 10),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          panelBuilder: (scrollController) => ProductDetailsPanel(
              productModel: widget.productModel,
              scrollController: scrollController,
              panelController: panelController),
          body: ProductViewer(id: widget.productModel.id, image: widget.productModel.image),
        ),
        bottomNavigationBar: productDetailBottomBar(context),
      ),
    );
  }
}
