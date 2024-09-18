import 'package:flutter/material.dart';
import 'package:jbb_app_v3/features/products/domain/product_model.dart';
import 'package:jbb_app_v3/features/products/presentation/widgets/app_bars.dart';
import 'package:jbb_app_v3/features/products/presentation/widgets/product_viewer.dart';
import 'package:jbb_app_v3/features/products/presentation/widgets/component_builders.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel productModel;

  const ProductDetailPage({
    super.key,
    required this.productModel,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool showImageViewer = true;
  AppBars appBars = AppBars();

  @override
  Widget build(BuildContext context) {
    ProductViewer productViewer =
        ProductViewer(productModel: widget.productModel);

    return Scaffold(
      bottomNavigationBar: appBars.bottomBuyCartBar(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(
              widget.productModel.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            backgroundColor: Colors.amber,
            expandedHeight: 365,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                alignment: Alignment.center,
                children: [
                  showImageViewer
                      ? productViewer.showImage(context)
                      : showModelView(context, productViewer),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Column(
                      children: [
                        IconButton.filled(
                          onPressed: () {},
                          iconSize: 24,
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.grey[850]),
                          ),
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.amber,
                          ),
                        ),
                        const SizedBox(height: 8),
                        IconButton.filled(
                          onPressed: () {
                            setState(() {
                              showImageViewer = !showImageViewer;
                            });
                          },
                          iconSize: 24,
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.grey[850]),
                          ),
                          icon: Icon(
                            showImageViewer
                                ? Icons.view_in_ar
                                : Icons.image_outlined,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            leading: Container(
              color: Colors.grey[850]?.withAlpha(155),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.amber,
                ),
              ),
            ),
            actions: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[850],
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.amber,
                      ),
                      color: Colors.grey[850],
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.amber,
                        ))
                  ],
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  const Divider(
                    thickness: 4,
                    height: 24,
                  ),
                  Text(
                    priceBuild(widget.productModel.price),
                    style: const TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  Text(
                    widget.productModel.category,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        backgroundColor: Colors.grey[300]),
                  ),
                  Text(
                    widget.productModel.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 8),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              RatingStarBuilder(
                                rating: (widget.productModel.averageRating),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 16, bottom: 16),
                                child: VerticalDivider(
                                  thickness: 2,
                                  width: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.share)),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(widget.productModel.description),
                  Text(widget.productModel.description),
                  Text(widget.productModel.description),
                  Text(widget.productModel.description),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showModelView(BuildContext context, ProductViewer productViewer) {
    return Stack(
      children: [
        productViewer.buildModelView(),
        Positioned(
          bottom: 10,
          left: 10,
          child: IconButton.filled(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return productViewer.buildModelViewWithControllers(context);
                },
              );
            },
            iconSize: 24,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.grey[850]),
            ),
            icon: const Icon(
              Icons.fullscreen,
              color: Colors.amber,
            ),
          ),
        ),
      ],
    );
  }
}
