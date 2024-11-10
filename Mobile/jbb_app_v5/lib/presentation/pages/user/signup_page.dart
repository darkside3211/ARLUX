import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/core/utils/terms.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/presentation/pages/user/login_page.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/auth_buttons.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_image.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:jbb_app_v5/presentation/widgets/input_fields.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  bool isAgree = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void showTerms(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 2,
          title: const Text(
            'Terms and Conditions for JBB-GOLD',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          scrollable: true,
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  isAgree = false;
                  Navigator.of(context).pop();
                });
              },
              child: const Text(
                'Disagree',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const Text('|'),
            TextButton(
              onPressed: () {
                setState(() {
                  isAgree = true;
                  Navigator.of(context).pop();
                });
              },
              child: const Text(
                'Agree',
                style: TextStyle(
                    color: AppColors.yellow, fontWeight: FontWeight.bold),
              ),
            ),
          ],
          content: const CreateTermsAndConditions(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = ref.read(authServiceProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff292929),
        iconTheme: const IconThemeData(color: AppColors.yellow),
        centerTitle: true,
        title: Text(
          'Create Account',
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
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        shadowColor: Colors.black,
        color: const Color(0xff292929),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: "Already have an Account? ",
            style: const TextStyle(color: Colors.white),
            children: [
              TextSpan(
                text: 'Login Now.',
                style: const TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
              ),
            ],
          ),
        ),
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
            TextField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
              decoration: customInputDecoration(label: 'email'),
            ),
            gapH16,
            TextField(
              obscureText: true,
              controller: _passwordController,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.visiblePassword,
              decoration: customInputDecoration(label: 'passwword'),
            ),
            gapH24,
            SizedBox(
              width: 256,
              child: AuthButtons().authButton(
                buttonText: 'Create Account',
                onPressed: () async {
                  if (isAgree) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(
                          color: Colors.amber,
                        ),
                      ),
                    );

                    final logged = await authService.signup(
                        email: _emailController.text,
                        password: _passwordController.text);

                    // ignore: use_build_context_synchronously
                    Navigator.of(context, rootNavigator: true).pop();

                    if (logged) {
                      ref.read(bottomNavIndexProvider.notifier).state = 0;
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    }
                  } else {
                    ToastFailure(
                        message: 'Agree to Terms and Conditions first.');
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: isAgree,
                  onChanged: (value) {
                    setState(() {
                      showTerms(context);
                    });
                  },
                  checkColor: AppColors.black,
                  activeColor: AppColors.yellow,
                ),
                const Text(
                  'I Agree to Terms and Conditions.',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
            gapH16,
            const SizedBox(
              height: Sizes.p24,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Divider(
                    color: Colors.amber,
                  )),
                  Text(
                    '  or  ',
                    style: TextStyle(
                        color: Colors.amber, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: Divider(
                    color: Colors.amber,
                  )),
                ],
              ),
            ),
            gapH16,
            SizedBox(
              width: 164,
              child: AuthButtons().googleAuthButton(
                isLogin: false,
                () async {
                  if (isAgree) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(
                          color: Colors.amber,
                        ),
                      ),
                    );

                    final logged = await authService.signInWithGoogle();

                    // ignore: use_build_context_synchronously
                    Navigator.of(context, rootNavigator: true).pop();

                    if (logged) {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    }
                  } else {
                    ToastFailure(
                        message: 'Agree to Terms and Conditions first');
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
