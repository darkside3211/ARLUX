import 'dart:convert';

import 'package:jbb_app_v4/features/jewelry/models/jewelry_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class JewelryLocalRepository {
  static const String keyJewelryData = "jewelry_data";

  static Future<void> saveJewelries(List<JewelryModel> jewelries) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(jewelries.map((e) => e.toJson()).toList());
    await prefs.setString(keyJewelryData, jsonString);
  }

  static Future<List<JewelryModel>> getJewelries() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(keyJewelryData);
    
    if (jsonString != null) {
      final jsonData = jsonDecode(jsonString);
      return jsonData.map((json) => JewelryModel.fromJson(json)).toList();
    } else {
      return List.empty();
    }
  }

  static Future<void> clearJewelries() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyJewelryData);
  }
}
