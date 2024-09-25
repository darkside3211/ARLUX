import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/presentation/pages/account/account_page.dart';
import 'package:jbb_app_v5/presentation/pages/account/login_page.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (user) {
        if (user != null) {
          Future.delayed(const Duration(seconds: 1));
          return const AccountPage();
        } else {
          Future.delayed(const Duration(seconds: 1));
          return const LoginPage();
        }
      },
      error: (err, stack) => Text("Error: $err"),
      loading: () =>
          const Center(child: CircularProgressIndicator(color: Colors.amber)),
    );
  }
}
