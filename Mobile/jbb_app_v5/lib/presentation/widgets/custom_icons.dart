import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';

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

class CustomIconWithCount extends StatelessWidget implements CustomIcons {
  final int count;
  final String title;
  final Icon icon;
  final VoidCallback? onPressed;
  const CustomIconWithCount({
    super.key,
    required this.count,
    required this.title,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 0, end: 10),
      badgeContent: Text(count.toString()),
      badgeStyle: const badges.BadgeStyle(
        badgeColor: AppColors.yellow,
      ),
      badgeAnimation: const badges.BadgeAnimation.scale(
        animationDuration: Duration(seconds: 1),
        loopAnimation: false,
        curve: Curves.fastOutSlowIn,
      ),
      child: _buildCard(context, title: title, icon: icon),
    );
  }

  Widget _buildCard(BuildContext context,
      {required String title, required Icon icon}) {
    return SizedBox(
      width: 128,
      child: Card(
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                gapH4,
                Text(
                  title,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                icon,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserIcon extends ConsumerWidget {
  const UserIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(),
      onTap: () {
        //TODO import image here
      },
      badgeContent: const Icon(Icons.edit),
      badgeStyle: const badges.BadgeStyle(
        badgeColor: AppColors.yellow,
      ),
      badgeAnimation: const badges.BadgeAnimation.scale(
        animationDuration: Duration(seconds: 1),
        loopAnimation: false,
        curve: Curves.fastOutSlowIn,
      ),
      child: const CircleAvatar(
        radius: 50,
        child: Icon(Icons.account_circle_rounded, size: 50),
      ),
    );
  }
}
