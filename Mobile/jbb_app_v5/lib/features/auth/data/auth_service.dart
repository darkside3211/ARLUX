import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:jbb_app_v5/core/network/network_core.dart';
import 'package:jbb_app_v5/core/utils/failure.dart';
import 'package:jbb_app_v5/features/auth/data/local_auth_service.dart';
import 'package:jbb_app_v5/features/auth/model/user_model.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Dio dio = DioInstance().getDioInstance();

  Future<bool> signup({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      String message = "Something went wrong.";

      if (e.code == 'weak-password') {
        message = 'The password you provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exist. Please login using your account.';
      }

      Failure.showErrorToast(message);
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signin({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      String message = 'Please Input email and Password';

      if (e.code == 'invalid-credential') {
        message = 'Wrong email or password';
      }

      Failure.showErrorToast(message);
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> passwordResetEmail({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      await signout();

      return true;
    } on FirebaseAuthException catch (e) {
      String message = 'Please Input email and Password';

      if (e.code == 'invalid-credential') {
        message = 'Wrong email or password';
      }

      Failure.showErrorToast(message);
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> signout() async {
    await _auth.signOut();
  }

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return false;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      return true;
    } on FirebaseAuthException catch (e) {
      Failure.showErrorToast("Google Sign-In failed: ${e.message}");
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel> getUserInfo({required String? token}) async {
    try {
      final Response result = await dio.request(
        "/users/auth/register",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          method: "GET",
        ),
      );

      if (result.statusCode == 200) {
        final json = result.data;

        final user = UserModel.fromJson(json);

        await LocalAuthService().cacheUserInfo(user: user);

        return user;
      } else {
        return LocalAuthService().getCachedUser();
      }
    } catch (e) {
      Failure.showErrorToast("Failed getting user info.");
      throw Exception(e.toString());
    }
  }

  Future<bool> updateUserInfo({
    required String? token,
    required String username,
    required String phone,
  }) async {
    try {
      final Response result = await dio.request(
        "/users/auth/register",
        data: {
          'username': username,
          'phone': phone,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          method: "PUT",
        ),
      );

      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Failure.showErrorToast("Failed updating user info.");
      throw Exception(e.toString());
    }
  }

  Future<String?> getFirebaseToken() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return await user.getIdToken();
    }

    return null;
  }

  Future<bool> addUserAddress({
    required AddressModel address,
    required String? token,
  }) async {
    try {
      final Response result = await dio.request(
        "/users/auth/register/address",
        data: {
          'address': address.toJson(),
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
      Failure.showErrorToast("Failed adding address.");
      return false;
    }
  }

  Future<bool> editUserAddress(
      {required String addressLabel,
      required AddressModel address,
      required String? token}) async {
    try {
      final Response result = await dio.request(
        "/users/auth/register/address",
        queryParameters: {
          'addressLabel': addressLabel,
        },
        data: {
          'address': address.toJson(),
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          method: "PUT",
        ),
      );

      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Failure.showErrorToast("Failed updating address.");
      return false;
    }
  }

  Future<bool> deleteUserAddress(
      {required String addressLabel, required String? token}) async {
    try {
      final Response result = await dio.request(
        "/users/auth/register/address",
        queryParameters: {
          'addressLabel': addressLabel,
        },
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
      Failure.showErrorToast("Failed updating address.");
      throw Exception(e.toString());
    }
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
Future<String?> getFirebaseToken(GetFirebaseTokenRef ref) async {
  final AuthService authService = ref.watch(authServiceProvider);
  return authService.getFirebaseToken();
}

@riverpod
Future<UserModel> getUserInfo(GetUserInfoRef ref) async {
  final AuthService authService = ref.watch(authServiceProvider);
  final String? token = await ref.watch(getFirebaseTokenProvider.future);

  final user = await authService.getUserInfo(token: token);

  ref.read(defaultAddressProvider.notifier).state = user.addresses[0];

  return user;
}

@riverpod
Future<bool> updateUserInfo(
  UpdateUserInfoRef ref, {
  required String username,
  required String phone,
}) async {
  final AuthService authService = ref.watch(authServiceProvider);
  final String? token = await ref.watch(getFirebaseTokenProvider.future);

  final result = await authService.updateUserInfo(
      token: token, username: username, phone: phone);

  if (result) {
    // ignore: unused_result
    ref.refresh(getUserInfoProvider);
  }

  return result;
}

@riverpod
Future<bool> addUserAddress(AddUserAddressRef ref,
    {required AddressModel address}) async {
  final AuthService authService = ref.watch(authServiceProvider);
  final String? token = await ref.watch(getFirebaseTokenProvider.future);

  final result =
      await authService.addUserAddress(token: token, address: address);

  if (result) {
    // ignore: unused_result
    ref.refresh(getUserInfoProvider);
  }

  return result;
}

@riverpod
Future<bool> editUserAddress(EditUserAddressRef ref,
    {required AddressModel address, required String addressLabel}) async {
  final AuthService authService = ref.watch(authServiceProvider);
  final String? token = await ref.watch(getFirebaseTokenProvider.future);

  final result = await authService.editUserAddress(
    token: token,
    address: address,
    addressLabel: addressLabel,
  );

  if (result) {
    // ignore: unused_result
    ref.refresh(getUserInfoProvider);
  }

  return result;
}

@riverpod
Future<bool> deleteUserAddress(DeleteUserAddressRef ref,
    {required String addressLabel}) async {
  final AuthService authService = ref.watch(authServiceProvider);
  final String? token = await ref.watch(getFirebaseTokenProvider.future);

  final result = await authService.deleteUserAddress(
      token: token, addressLabel: addressLabel);

  if (result) {
    // ignore: unused_result
    ref.refresh(getUserInfoProvider);
  }

  return result;
}
