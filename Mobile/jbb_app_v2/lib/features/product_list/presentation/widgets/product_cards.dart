import 'package:flutter/material.dart';
import 'package:jbb_app_v2/core/params/params.dart';
import 'package:jbb_app_v2/core/theme/theme_colors.dart';
import 'package:jbb_app_v2/features/product_list/model/product_model.dart';
import 'package:jbb_app_v2/features/product_list/presentation/pages/product_details_page.dart';
import 'package:jbb_app_v2/features/product_list/presentation/widgets/icon_widgets.dart';

class ProductCards extends StatelessWidget {
  final ProductModel productModel;
  const ProductCards({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    final averageRating = productModel.rating['rate'] ?? 0.0;
    final rateCount = productModel.rating['count'] ?? 0;
    return Material(
      child: InkWell(
        splashColor: Colors.amber,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(
                productModel: productModel,
              ),
            ),
          );
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: primaryBlack),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: productModel.id,
                    child: Image.network(
                      productModel.image,
                      fit: BoxFit.scaleDown,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Container(
                            width: 64,
                            height: 128,
                            color: Colors.transparent,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      productModel.category,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w100
                      ),
                    ),
                  ),
                  Text(
                    productModel.title,
                    maxLines: 1, // Limit to one line
                    overflow: TextOverflow
                        .ellipsis, // Add ellipsis if title is too long
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      priceBuild(productModel.price),
                      style: const TextStyle(
                          color: secondaryAmber,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(averageRating.toStringAsFixed(1)),
                        const Icon(
                          Icons.star,
                          color: secondaryAmber,
                          size: 16,
                        ),
                        const VerticalDivider(thickness: 2),
                        Text('${rateCount.toString()} sold'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
                alignment: Alignment.topRight,
                child: buildWishList(context, isWished: false)),
          ],
        ),
      ),
    );
  }
}
