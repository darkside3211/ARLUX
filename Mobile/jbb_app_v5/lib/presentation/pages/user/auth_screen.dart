import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/presentation/pages/user/user_page.dart';
import 'package:jbb_app_v5/presentation/widgets/no_user.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (user) {
        if (user != null) {
          ref.read(getUserInfoProvider);
          return const UserPage();
        } else {
          return const NoUser(
            title: 'Account Page',
            icon: Icons.no_accounts,
          );
        }
      },
      error: (err, stack) => Text("Error: $err"),
      loading: () =>
          const Center(child: CircularProgressIndicator(color: Colors.amber)),
    );
  }
}
