import 'package:flutter/material.dart';
import 'package:jbb_app_v2/core/params/params.dart';
import 'package:jbb_app_v2/core/theme/theme_colors.dart';
import 'package:jbb_app_v2/features/product_list/model/product_model.dart';
import 'package:jbb_app_v2/features/product_list/presentation/widgets/rating_star_builder.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProductDetailsPanel extends StatelessWidget {
  final ScrollController scrollController;
  final PanelController panelController;
  final ProductModel productModel;

  const ProductDetailsPanel({
    super.key,
    required this.productModel,
    required this.scrollController,
    required this.panelController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      controller: scrollController,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.menu_sharp),
          onPressed: togglePanel,
        ),
        Text(
          priceBuild(productModel.price),
          style: const TextStyle(
              color: secondaryAmber, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        Text(
          productModel.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 12),
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    RatingStarBuilder(
                      rating: (productModel.rating['rate']).toDouble(),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 8, right: 8, top: 16, bottom: 16),
                      child: VerticalDivider(
                        thickness: 2,
                        width: 8,
                      ),
                    ),
                    Text('${productModel.rating['count'].toString()} sold'),
                  ],
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border_outlined))
            ],
          ),
        ),
        const Divider(thickness: 2, height: 16),
        const SizedBox(
          height: 32,
          child: Text(
            'Product Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Text(productModel.description),
        const SizedBox(height: 24),
      ],
    );
  }

  void togglePanel() {
    panelController.isPanelOpen
        ? panelController.close()
        : panelController.open();
  }
}
