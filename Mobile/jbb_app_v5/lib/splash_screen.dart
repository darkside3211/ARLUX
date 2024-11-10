import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/features/cart/data/cart_repository.dart';
import 'package:jbb_app_v5/features/order/data/order_repository.dart';
import 'package:jbb_app_v5/presentation/pages/home/home_screen.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      asyncNavigationCallback: () async {
        try {
          final status = await ref.read(authStateProvider.future);
          if (status != null) {
            await ref.read(getUserInfoProvider.future);
            await ref.read(getBagItemsProvider.future);
            await ref.read(getOrdersProvider.future);
          }
        } catch (e) {
          ToastFailure(message: 'You seem to be offline.');
        } finally {
          if (context.mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          }
        }
      },
      backgroundColor: const Color(0xff292929),
      childWidget: SizedBox(
        width: 200,
        height: 200,
        child: Image.asset(
          'assets/icons/jbb_logo.png',
          fit: BoxFit.cover,
        ),
      ),
      animationDuration: const Duration(seconds: 3),
      nextScreen: HomeScreen(),
    );
  }
}
