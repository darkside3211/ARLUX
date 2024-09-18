import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/features/auth/presentation/widgets/input_fields.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final EmailPasswordField emailPasswordField = EmailPasswordField(context);
    final authService = ref.read(authServiceProvider);

    return Scaffold(
      backgroundColor: const Color(0xff292929),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(32),
        child: toSignUpPage(context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 32),
              SizedBox(
                height: 128,
                child: Image.asset(
                  'assets/icons/jbb_logo.jpeg',
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                'Create an Account',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.amber, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              emailPasswordField.emailAddress(),
              const SizedBox(height: 24),
              emailPasswordField.password(),
              const SizedBox(height: 64),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    await authService.signup(
                      email: emailPasswordField.getEmail(),
                      password: emailPasswordField.getPassword(),
                    );
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  RichText toSignUpPage(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "Already Have an Account? ",
        style: const TextStyle(color: Colors.white),
        children: [
          TextSpan(
            text: 'Login',
            style: const TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pop(context);
              },
          ),
        ],
      ),
    );
  }
}
