import 'package:flutter/material.dart';
import 'package:jbb_app_v4/features/jewelry/presentation/app_bars/jewelry_search_field.dart';

abstract class JewelryListAppBar {}

class JewelryListTopBar extends StatelessWidget
    implements JewelryListAppBar, PreferredSizeWidget {
  final String searchedText;
  const JewelryListTopBar({super.key, this.searchedText = ''});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: JewelrySearchField(
        initalText: searchedText,
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
