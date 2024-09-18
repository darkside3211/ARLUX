import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/features/auth/presentation/pages/home.dart';
import 'package:jbb_app_v5/features/auth/presentation/pages/login_page.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (user) {
        if (user != null) {
          return const Home();
        } else {
          return const LoginPage();
        }
      },
      error: (err, stack) => Center(child: Text("Error: $err")),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
