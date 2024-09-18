import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v4/features/jewelry/presentation/app_bars/home_app_bar.dart';
import 'package:jbb_app_v4/features/jewelry/presentation/jewelry_screen/jewerly_home.dart';
import 'package:jbb_app_v4/features/jewelry/presentation/providers/bottom_nav_provider.dart';

class JewelryScreen extends ConsumerWidget {
  JewelryScreen({super.key});

  final List<Widget> pages = [
    const JewerlyHome(),
    const Center(child: Text("Shopping Bag Page")),
    const Center(child: Text("Wishlist Page")),
    const Center(child: Text("Account Page")),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      appBar: const HomeTopBar(isDefault: true),
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: currentIndex,
        onTap: (value) {
          ref.read(bottomNavIndexProvider.notifier).state = value;
        },
      ),
      body: pages[currentIndex],
    );
  }
}
