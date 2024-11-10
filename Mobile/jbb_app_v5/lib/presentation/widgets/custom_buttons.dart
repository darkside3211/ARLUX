import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/presentation/pages/cart/cart_bottom_sheet.dart';
import 'package:jbb_app_v5/presentation/pages/home/home_screen.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';

enum ButtonType { custom, cart, wishlist, theme, buy }

abstract class CustomButtons {
  final ButtonType type = ButtonType.custom;
}

class CartElevatedButton extends ConsumerWidget implements CustomButtons {
  final bool isConfirm;
  final String? customLabel;
  final Color? customBgColor;
  final Color? customFgColor;
  final VoidCallback? customFunction;

  const CartElevatedButton({
    super.key,
    required this.isConfirm,
    this.customFunction,
    this.customLabel,
    this.customBgColor,
    this.customFgColor,
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
          backgroundColor: customBgColor ?? const Color(0xff292929),
          foregroundColor: customFgColor ?? AppColors.yellow),
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
