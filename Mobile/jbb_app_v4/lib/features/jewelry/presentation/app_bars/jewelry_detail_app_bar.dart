import 'package:flutter/material.dart';

abstract class JewelryDetailAppBar {}

class JewelryDetailTopBar extends StatelessWidget implements JewelryDetailAppBar, PreferredSizeWidget {
  
  const JewelryDetailTopBar({super.key, required this.jewelryName});

  final String jewelryName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(jewelryName, style: Theme.of(context).textTheme.titleLarge),
      backgroundColor: Colors.amber,
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}