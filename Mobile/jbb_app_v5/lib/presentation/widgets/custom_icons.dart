import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:jbb_app_v5/core/constants/app_colors.dart';

abstract class CustomIcons {}

class BagIconWithCount extends StatelessWidget implements CustomIcons {
  final int bagCount;
  const BagIconWithCount({super.key, this.bagCount = 0});

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      badgeContent: Text(bagCount.toString()),
      badgeStyle: const badges.BadgeStyle(
        badgeColor: AppColors.yellow,
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

class OrderIconWithCount extends StatelessWidget implements CustomIcons {
  final int orderCount;
  const OrderIconWithCount({super.key, this.orderCount = 0});

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      badgeContent: Text(orderCount.toString()),
      badgeStyle: const badges.BadgeStyle(
        badgeColor: AppColors.yellow,
      ),
      badgeAnimation: const badges.BadgeAnimation.scale(
        animationDuration: Duration(seconds: 1),
        loopAnimation: false,
        curve: Curves.fastOutSlowIn,
      ),
      child: const Icon(Icons.all_inbox),
    );
  }
}
