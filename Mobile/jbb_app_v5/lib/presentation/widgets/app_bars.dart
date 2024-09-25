import 'package:flutter/material.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_search_field.dart';

abstract class AppBars extends PreferredSizeWidget {}

class HomeTopBar extends StatelessWidget implements AppBars {
  final bool isDefault;
  final VoidCallback? onNotificationPressed;

  const HomeTopBar({
    super.key,
    required this.isDefault,
    this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff292929),
      shadowColor: Colors.grey,
      elevation: 8,
      iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.amber),
      title: Image.asset(
        'assets/icons/jbb_logo.jpeg',
        width: 120,
        height: 120,
      ),
      centerTitle: true,
      leading: isDefault
          ? IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu),
            )
          : IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios)),
      actions: [
        IconButton(
          onPressed: () {
            //Notification
            onNotificationPressed;
          },
          icon: const Icon(Icons.notifications),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class ProductDetailTopBar extends StatelessWidget implements AppBars {
  final String productName;

  const ProductDetailTopBar({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        productName,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      backgroundColor: Colors.amber,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class ProductListTopBar extends StatelessWidget implements AppBars {
  final String searchedText;

  const ProductListTopBar({super.key, required this.searchedText});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: ProductSearchField(
        initialText: searchedText,
      ),
      backgroundColor: Colors.amber,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.sort),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
