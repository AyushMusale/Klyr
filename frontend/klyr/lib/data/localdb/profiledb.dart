import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ProfileStorage{
  static const _key = 'user_profile';

  static Future<void> saveProfile(Map<String,dynamic> profile)async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(profile));
  }

  static Future<Map<String,dynamic>?> getProfile()async{
    final prefs = await SharedPreferences.getInstance();
    final profile = prefs.getString(_key);
    if (profile == null) return null ;
    return jsonDecode(profile);
  }

  static Future<void> clearProfile()async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}