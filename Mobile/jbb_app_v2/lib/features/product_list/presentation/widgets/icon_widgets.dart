import 'package:flutter/material.dart';
import 'package:jbb_app_v2/features/product_list/presentation/pages/products_list_page.dart';

Widget showIconError({required Widget symbol, required String message}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        symbol,
        const SizedBox(height: 16),
        Text(message),
      ],
    ),
  );
}

Widget buildWishList(BuildContext context, {required bool isWished}) {
  return IconButton(
      onPressed: () {},
      icon: Icon(isWished ? Icons.favorite : Icons.favorite_border, color: isWished ? Colors.red : Theme.of(context).iconTheme.color));
}

Widget avatarIcon(BuildContext context, {required String title}) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ProductsListPage(category: title);
          },
        ),
      );
    },
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.amber,
          ),
          child: const Icon(
            Icons.insert_emoticon,
            size: 64,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
