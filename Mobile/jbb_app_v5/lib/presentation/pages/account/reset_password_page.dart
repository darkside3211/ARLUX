import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/presentation/widgets/app_bars.dart';
import 'package:jbb_app_v5/presentation/widgets/auth_buttons.dart';
import 'package:jbb_app_v5/presentation/widgets/input_fields.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final EmailPasswordField emailPasswordField = EmailPasswordField(context);
    final authService = ref.read(authServiceProvider);

    return Scaffold(
      appBar: const HomeTopBar(isDefault: false),
      backgroundColor: const Color(0xff292929),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: buildRequest(
            emailField: emailPasswordField.emailAddress(),
            onPressed: () async {
              await authService.passwordResetEmail(
                  email: emailPasswordField.getEmail());
              await Future.delayed(const Duration(milliseconds: 500));

              setState(() {
                Navigator.pop(context);
              });

              Fluttertoast.showToast(
                  msg: 'Reset email sent.',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.SNACKBAR,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 14.0);
            },
          ),
        ),
      ),
    );
  }

  Widget buildRequest(
      {VoidCallback? onPressed, required TextField emailField}) {
    return Column(
      children: [
        SizedBox(
          height: 190,
          child: Image.asset(
            'assets/icons/jbb_logo.jpeg',
            alignment: Alignment.center,
            fit: BoxFit.contain,
          ),
        ),
        Text(
          'Reset Password',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        gapH16,
        emailField,
        gapH32,
        SizedBox(
          width: double.infinity,
          child: AuthButtons().authButton(
            buttonText: 'Send Reset Email',
            onPressed: onPressed,
          ),
        ),
        gapH16
      ],
    );
  }
}
