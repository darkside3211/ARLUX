import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/presentation/pages/user/auth_screen.dart';
import 'package:jbb_app_v5/presentation/pages/cart/cart_page.dart';
import 'package:jbb_app_v5/presentation/pages/home/home_page.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/app_bars.dart';
import 'package:jbb_app_v5/presentation/widgets/bottom_bars.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final List<Widget> pages = [
    const HomePage(),
    const CartPage(),
    const AuthScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    void showBackDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Exit App'),
            content: const Text(
              'Are you sure you want to exit the app?',
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge),
                child: const Text(
                  'No',
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge),
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.amber),
                ),
                onPressed: () {
                  FlutterExitApp.exitApp(iosForceExit: true);
                },
              ),
            ],
          );
        },
      );
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        showBackDialog();
      },
      child: Scaffold(
        appBar: const HomeTopBar(isDefault: true),
        bottomNavigationBar: HomeNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            ref.read(bottomNavIndexProvider.notifier).state = value;
          },
        ),
        body: pages[currentIndex],
      ),
    );
  }
}
