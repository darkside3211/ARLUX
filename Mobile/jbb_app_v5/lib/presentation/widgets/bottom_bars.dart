import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/core/network/network_core.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/bottom_sheets/product_bottom_sheet.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_buttons.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_icons.dart';

abstract class BottomBars {}

class HomeNavigationBar extends ConsumerWidget implements BottomBars {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HomeNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bagCount = ref.watch(bagItemCountProvider);
    final orderCount = ref.watch(orderStatusCountProvider);
    return SizedBox(
      height: const Size.fromHeight(64).height,
      child: BottomNavigationBar(
        backgroundColor: const Color(0xff292929),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.yellow, // Color of the selected item
        unselectedItemColor: Colors.grey[400],
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: BagIconWithCount(bagCount: bagCount),
            label: 'Bag',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: currentIndex,
        onTap: onTap,
      ),
    );
  }
}

class ProductBuyCartBar extends StatelessWidget implements BottomBars {
  final String productId;

  const ProductBuyCartBar({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.yellow, width: 2.0))),
      child: BottomAppBar(
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(onPressed: () {}, icon: const Icon(Icons.help)),
              IconButton(
                icon: const Icon(Icons.chat),
                onPressed: () {
                  LaunchMessenger();
                },
              ),
              const Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CartElevatedButton(isConfirm: true),
                  SizedBox(width: 8.0),
                  CartElevatedButton(isConfirm: false),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class CartBottomBar extends ConsumerStatefulWidget {
  final bool isEditing;
  final List<double>? selectedItemPrices;

  const CartBottomBar(
      {super.key, required this.isEditing, this.selectedItemPrices});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartBottomBarState();
}

class _CartBottomBarState extends ConsumerState<CartBottomBar> {
  @override
  Widget build(BuildContext context) {
    return const BottomAppBar();
  }
}
