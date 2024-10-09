import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/presentation/pages/cart/cart_bottom_sheet.dart';
import 'package:jbb_app_v5/presentation/pages/home/home_screen.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/providers/theme_notifier.dart';

enum ButtonType { custom, cart, wishlist, theme, buy }

abstract class CustomButtons {
  final ButtonType type = ButtonType.custom;
}

class BuyElevatedButton extends ConsumerWidget implements CustomButtons {
  const BuyElevatedButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return ElevatedButton(
      onPressed: () {
        authState.when(
            data: (user) {
              if (user != null) {
                //TODO buy now
              } else {
                ref.read(bottomNavIndexProvider.notifier).state = 2;
                Navigator.pop(context);
              }
            },
            error: (err, stack) {},
            loading: () => null);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.yellow,
          foregroundColor: const Color(0xff292929)),
      child: const Text('Buy Now'),
    );
  }

  @override
  ButtonType get type => ButtonType.buy;
}

class CheckoutElevatedButton extends StatelessWidget implements CustomButtons {
  const CheckoutElevatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle Buy Now button press
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.yellow,
          foregroundColor: const Color(0xff292929)),
      child: const Text('Checkout'),
    );
  }

  @override
  ButtonType get type => ButtonType.buy;
}

class CartElevatedButton extends ConsumerWidget implements CustomButtons {
  final bool isConfirm;
  final VoidCallback? customFunction;

  const CartElevatedButton({
    super.key,
    required this.isConfirm,
    this.customFunction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return ElevatedButton(
      onPressed: () {
        authState.when(
            data: (user) {
              if (user != null) {
                isConfirm ? customFunction?.call() : _showCartSheet(context);
              } else {
                ref.read(bottomNavIndexProvider.notifier).state = 2;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomeScreen();
                    },
                  ),
                );
              }
            },
            error: (err, stack) {},
            loading: () => null);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff292929),
          foregroundColor: AppColors.yellow),
      child: const Text('Add to Bag'),
    );
  }

  @override
  ButtonType get type => ButtonType.cart;
}

void _showCartSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allow the bottom sheet to take full height
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context)
              .viewInsets
              .bottom, // Handle keyboard overlap
        ),
        child: const AddCartBottomSheet(), // Content inside the bottom sheet
      );
    },
  );
}

class ThemeToggleButton extends ConsumerWidget implements CustomButtons {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode themeMode = ref.watch(themeNotifierProvider);
    return ListTile(
      leading: themeMode == ThemeMode.light
          ? const Icon(Icons.brightness_2)
          : const Icon(Icons.brightness_5),
      title:
          Text(themeMode == ThemeMode.light ? 'Theme(Light)' : 'Theme(Dark)'),
      trailing: Switch(
        value: themeMode == ThemeMode.light,
        onChanged: (value) =>
            ref.read(themeNotifierProvider.notifier).toggleTheme(),
      ),
    );
  }

  @override
  ButtonType get type => ButtonType.theme;
}
