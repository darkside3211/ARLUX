import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

abstract class CustomIcons {}

class BagIconWithCount extends StatelessWidget implements CustomIcons {
  final int bagCount;
  const BagIconWithCount({super.key, this.bagCount = 1});

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      badgeContent: Text(bagCount.toString()),
      badgeStyle: const badges.BadgeStyle(
        badgeColor: Colors.amber,
      ),
      badgeAnimation: const badges.BadgeAnimation.scale(
        animationDuration: Duration(seconds: 1),
        loopAnimation: false,
        curve: Curves.fastOutSlowIn,
      ),
      child: const Icon(Icons.shopping_bag),
    );
  }
}
