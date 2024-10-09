import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/presentation/pages/account/auth_screen.dart';
import 'package:jbb_app_v5/presentation/pages/cart/cart_page.dart';
import 'package:jbb_app_v5/presentation/pages/home/home_page.dart';
import 'package:jbb_app_v5/presentation/pages/order/order_page.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/app_bars.dart';
import 'package:jbb_app_v5/presentation/widgets/bottom_bars.dart';
import 'package:jbb_app_v5/presentation/widgets/menus.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final List<Widget> pages = [
    const HomePage(),
    const CartPage(),
    const OrderPage(),
    const AuthScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      appBar: const HomeTopBar(isDefault: true), 
      bottomNavigationBar: HomeNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          ref.read(bottomNavIndexProvider.notifier).state = value;
        },
      ),
      body: pages[currentIndex],
      drawer: const HomeMenuDrawer(),
    );
  }
}