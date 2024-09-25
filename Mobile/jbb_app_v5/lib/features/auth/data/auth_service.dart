import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:jbb_app_v5/core/network/network_core.dart';
import 'package:jbb_app_v5/core/utils/failure.dart';
import 'package:jbb_app_v5/features/products/model/product_model.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Dio dio = DioInstance().getDioInstance();

  Future<void> signup({
    required String email,
    required String password,
    required username,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      String? token = await userCredential.user?.getIdToken();

      await _registerUser(email: email, username: username, token: token);

      await Future.delayed(const Duration(seconds: 1));
    } on FirebaseAuthException catch (e) {
      String message = "Something went wrong.";

      if (e.code == 'weak-password') {
        message = 'The password you provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exist. Please login using your account.';
      }

      Failure.showErrorToast(message);
    } catch (e) {
      Failure.showErrorToast(e.toString());
    }
  }

  Future<void> signin({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));
    } on FirebaseAuthException catch (e) {
      String message = 'Please Input email and Password';

      if (e.code == 'invalid-credential') {
        message = 'Wrong email or password';
      }

      Failure.showErrorToast(message);
    } catch (e) {
      Failure.showErrorToast(e.toString());
    }
  }

  Future<void> passwordResetEmail({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    await signout();
  }

  Future<void> signout() async {
    await _auth.signOut();

    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      String? token = await userCredential.user?.getIdToken();

      await _registerUser(
        token: token!,
        email: googleUser.email,
        username: googleUser.displayName!,
      );
    } on FirebaseAuthException catch (e) {
      Failure.showErrorToast("Google Sign-In failed: ${e.message}");
    } catch (e) {
      Failure.showErrorToast(e.toString());
    }
  }

  Future<void> _registerUser({
    required String email,
    required String username,
    required String? token,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'email': email,
        'username': username,
      };

      final Response result = await dio.request(
        '/register',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          method: "POST",
        ),
      );

      if (result.statusCode == 201) {
        Failure.showErrorToast('User registered successfully');
      } else if (result.statusCode == 200) {
        Failure.showErrorToast('User already exists');
      } else {
        Failure.showErrorToast(
            'Unexpected server response: ${result.statusCode}');
      }
    } catch (e) {
      Failure.showErrorToast('Error calling backend: ${e.toString()}');
    }
  }

  Future<bool> addProductToBag({
    required String productId,
    required int quantity,
    required String size,
  }) async {
    try {
      String? token = await _getFirebaseToken();

      final Response result = await dio.request(
        '/users/auth/cart',
        data: {
          "productId": productId,
          "quantity": quantity,
          "size": size,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          method: "POST",
        ),
      );

      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      ToastFailure(message: e.toString());
      return false;
    }
  }

  Future<List<ProductModel>> getBagItems() async {
    try {
      String? token = await _getFirebaseToken();

      final Response result = await dio.request(
        "/users/auth/cart",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          method: "GET",
        ),
      );

      if (result.statusCode == 200) {
        final json = result.data as List<dynamic>;

        final List<ProductModel> jewelries =
            json.map((item) => ProductModel.fromJson(item)).toList();

        return jewelries;
      } else {
        return List.empty();
      }
    } catch (e) {
      //ToastFailure(message: e.toString());
      return List.empty();
    }
  }

  Future<bool> removeBagItem({required String productId}) async {
    try {
      String? token = await _getFirebaseToken();

      final Response result = await dio.request(
        "/users/auth/cart/$productId",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          method: "DELETE",
        ),
      );

      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      ToastFailure(message: e.toString());
      return false;
    }
  }

  Future<String?> _getFirebaseToken() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return await user.getIdToken();
    }

    return null;
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

@riverpod
Future<bool> addProductToBag(
  AddProductToBagRef ref, {
  required String productId,
  required int quantity,
  required String size,
}) async {
  final AuthService authService = ref.watch(authServiceProvider);
  final bool result = await authService.addProductToBag(
    productId: productId,
    quantity: quantity,
    size: size,
  );
  if (result) {
    // ignore: unused_result
    ref.refresh(getBagItemsProvider);
  }

  return result;
}

@riverpod
Future<List<ProductModel>> getBagItems(GetBagItemsRef ref) async {
  final AuthService authService = ref.watch(authServiceProvider);
  final items = await authService.getBagItems();
  
  ref.read(bagItemCountProvider.notifier).state = items.length;

  return items;
}

@riverpod
Future<bool> removeBagItem(RemoveBagItemRef ref,
    {required String productId}) async {
  final AuthService authService = ref.watch(authServiceProvider);
  final bool result = await authService.removeBagItem(productId: productId);

  if (result) {
    // ignore: unused_result
    ref.refresh(getBagItemsProvider);
  }

  return result;
}
