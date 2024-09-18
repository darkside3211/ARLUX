import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

class AuthService {
  Future<void> signup({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));
    } on FirebaseAuthException catch (e) {
      String message = "Something went wrong.";

      if (e.code == 'weak-password') {
        message = 'The password you provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exist. Please login using your account.';
      }

      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.grey[850],
          textColor: Colors.white,
          fontSize: 14.0);
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'ERROR!',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0);
    }
  }

  Future<void> signin({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));
    } on FirebaseAuthException catch (e) {
      String message = 'Please Input email and Password';

      if (e.code == 'invalid-credential') {
        message = 'Wrong email or password';
      }

      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.grey[850],
          textColor: Colors.white,
          fontSize: 14.0);
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'ERROR!',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0);
    }
  }

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();

    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> signInWithGoogle() async {
    try {
      
    } catch (e) {
      
    }
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

@riverpod
AuthService authService(AuthServiceRef ref) {
  return AuthService();
}

@riverpod
Stream<User?> authState(AuthStateRef ref) {
  return FirebaseAuth.instance.authStateChanges();
}
