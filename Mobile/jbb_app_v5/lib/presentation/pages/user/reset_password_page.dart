import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/presentation/pages/user/login_page.dart';
import 'package:jbb_app_v5/presentation/widgets/auth_buttons.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_image.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:jbb_app_v5/presentation/widgets/input_fields.dart';

class ResetPasswordPage extends ConsumerWidget {
  final bool isDefault;
  const ResetPasswordPage({super.key, this.isDefault = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final EmailPasswordField emailPasswordField = EmailPasswordField();
    final authService = ref.read(authServiceProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff292929),
        iconTheme: const IconThemeData(color: AppColors.yellow),
        centerTitle: true,
        title: Text(
          'Reset Password',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.amber),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.help)),
        ],
        elevation: 2,
        shadowColor: Colors.black,
      ),
      backgroundColor: const Color(0xff292929),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: SizedBox(
                height: 128,
                width: 128,
                child: CustomSingleImage(
                    image: 'assets/icons/jbb_logo.png',
                    disableGestures: true,
                    aspectRatio: 1),
              ),
            ),
            const Divider(
              color: Colors.amber,
            ),
            emailPasswordField.emailAddress(),
            gapH24,
            SizedBox(
              width: 256,
              child: AuthButtons().authButton(
                buttonText: 'Send Request',
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    ),
                  );

                  final logged = await authService.passwordResetEmail(
                    email: emailPasswordField.getEmail(),
                  );

                  // ignore: use_build_context_synchronously
                  Navigator.of(context, rootNavigator: true).pop();

                  if (logged) {
                    if (isDefault) {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                      showDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          barrierDismissible: true,
                          builder: (context) => AlertDialog(
                                title: Row(
                                  children: [
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: const Icon(Icons.close)),
                                  ],
                                ),
                                content: const SizedBox(
                                  height: 128,
                                  child: IconedFailure(
                                    message:
                                        'Please check your email to reset password.',
                                    displayIcon: Icon(Icons.email_outlined),
                                  ),
                                ),
                              ));
                    } else {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
