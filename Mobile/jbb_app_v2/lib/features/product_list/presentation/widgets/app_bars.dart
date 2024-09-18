import 'package:flutter/material.dart';
import 'package:jbb_app_v2/core/constants/constants.dart';
import 'package:jbb_app_v2/core/theme/theme_colors.dart';
import 'package:jbb_app_v2/features/product_list/presentation/widgets/icon_widgets.dart';

AppBar titleAppBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    title: const Text(
      'JBB STORE',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber),
    ),
    leading: IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {},
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.notifications),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.favorite),
      ),
    ],
  );
}

AppBar searchBar(BuildContext context, VoidCallback filterToggled) {
  return AppBar(
    titleSpacing: 8,
    elevation: 0,
    centerTitle: false,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    actions: [
      IconButton(
        onPressed: filterToggled,
        icon: const Icon(Icons.filter_list),
      ),
    ],
    title: TextField(
      onSubmitted: (value) {},
      decoration: InputDecoration(
        filled: !isDark(context),
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.search),
        contentPadding: const EdgeInsets.all(8),
        hintText: 'Search...',
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    ),
  );
}

AppBar productDetailBar(context) {
  return AppBar(
    backgroundColor: secondaryBlack,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new),
      onPressed: () => Navigator.pop(context),
    ),
    actions: [
      buildWishList(context, isWished: false),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.shopping_bag_outlined),
      ),
    ],
  );
}
