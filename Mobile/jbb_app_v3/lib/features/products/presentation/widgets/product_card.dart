import 'package:flutter/material.dart';
import 'package:jbb_app_v3/features/products/domain/product_model.dart';
import 'package:jbb_app_v3/features/products/presentation/pages/product_detail_page.dart';
import 'package:jbb_app_v3/features/products/presentation/widgets/component_builders.dart';

Widget productCard(BuildContext context, {required ProductModel productModel}) {
  return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProductDetailPage(productModel: productModel);
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.withAlpha(10),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                Image.asset(
                  'assets${productModel.imageUrl}',
                  fit: BoxFit.scaleDown,
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: IconButton.filled(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border),
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Colors.amber.withAlpha(100))),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              productModel.category,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              priceBuild(productModel.price),
              style: const TextStyle(
                  color: Colors.amber,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              productModel.name,
              maxLines: 1, // Limit to one line
              overflow:
                  TextOverflow.ellipsis, // Add ellipsis if title is too long
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            RatingStarBuilder(rating: productModel.averageRating)
          ],
        ),
      ));
}
