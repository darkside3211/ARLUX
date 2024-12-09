import 'dart:convert';
import 'package:jbb_app_v5/features/auth/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthService {
  Future<void> cacheUserInfo({required UserModel user}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final userModel = jsonEncode(user.toJson());

      await prefs.setString('cached_user', userModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> getCachedUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final userModel = prefs.getString('cached_user');

      if (userModel != null) {
        return UserModel.fromJson(jsonDecode(userModel));
      } else {
        throw Exception('No user cached');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future clearCache() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.clear();
    } catch (e) {
      throw Exception(e);
    }
  }
}
