import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/presentation/widgets/auth_buttons.dart';
import 'package:jbb_app_v5/presentation/widgets/input_fields.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    final EmailPasswordField emailPasswordField = EmailPasswordField(context);
    final authService = ref.read(authServiceProvider);

    return Scaffold(
      backgroundColor: const Color(0xff292929),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(32),
        child: changeLoginReg(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 190,
                child: Image.asset(
                  'assets/icons/jbb_logo.jpeg',
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                isLogin ? 'Login Account' : 'Create an Account',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.amber, fontWeight: FontWeight.bold),
              ),
              gapH16,
              emailPasswordField.emailAddress(),
              gapH16,
              emailPasswordField.password(),
              gapH32,
              SizedBox(
                width: double.infinity,
                child: AuthButtons().authButton(
                    buttonText: isLogin ? 'Login' : 'Create Account',
                    onPressed: () async {
                      isLogin
                          ? await authService.signin(
                              email: emailPasswordField.getEmail(),
                              password: emailPasswordField.getPassword())
                          : await authService.signup(
                              email: emailPasswordField.getEmail(),
                              password: emailPasswordField.getPassword(),
                              username: emailPasswordField.getUsername(),
                            );
                    }),
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
                width: 192,
                child: AuthButtons().googleAuthButton(
                  isLogin: isLogin,
                  () async {
                    await authService.signInWithGoogle();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  RichText changeLoginReg() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: isLogin ? "Already Have an Account? " : "Don't have an Account? ",
        style: const TextStyle(color: Colors.white),
        children: [
          TextSpan(
            text: isLogin ? 'Login Here' : 'Create an Account',
            style: const TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
          ),
        ],
      ),
    );
  }
}
