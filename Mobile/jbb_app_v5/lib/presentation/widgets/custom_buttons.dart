import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/presentation/pages/cart/cart_bottom_sheet.dart';
import 'package:jbb_app_v5/presentation/pages/home/home_screen.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/bottom_sheets/product_bottom_sheet.dart';

enum ButtonType { custom, cart, wishlist, theme, buy }

abstract class CustomButtons {
  final ButtonType type = ButtonType.custom;
}

class BuyElevatedButton extends ConsumerWidget implements CustomButtons {
  final bool isConfirm;
  final String? customLabel;
  final VoidCallback? customFunction;
  const BuyElevatedButton({
    super.key,
    required this.isConfirm,
    this.customLabel,
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
                isConfirm ? customFunction?.call() : _showBuySheet(context);
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
  final String? customLabel;
  final VoidCallback? customFunction;

  const CartElevatedButton({
    super.key,
    required this.isConfirm,
    this.customFunction,
    this.customLabel,
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
      child: Text(customLabel ?? "Add to bag"),
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

void _showBuySheet(BuildContext context) {
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
        child: ProductBottomSheet(
            onPressed: (quantity, size) {},
            label: 'Checkout'), // Content inside the bottom sheet
      );
    },
  );
}
