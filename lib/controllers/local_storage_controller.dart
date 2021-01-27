import 'dart:convert';
import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageUtils {
  SharedPreferences _prefs;
  static final LocalStorageUtils _instance = LocalStorageUtils._internal();

  factory LocalStorageUtils() {
    return _instance;
  }

  LocalStorageUtils._internal();

  Future<dynamic> init() async =>
      _prefs = await SharedPreferences.getInstance();

  bool addUserAuthToken(String token) {
    try {
      _prefs.setString("token", token);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool addUserInfoToken(String token) {
    try {
      _prefs.setString("user_info_token", token);
      return true;
    } catch (e) {
      return false;
    }
  }

  String getAuthToken() {
    return _prefs.getString("token");
  }

  String getUserInfoToken() {
    return _prefs.getString("user_info_token");
  }

  String getUserId() {
    return _prefs.getString("user_info_token")?.split("|")[1];
  }

  bool isUserLoggedIn() {
    return _prefs.getString('token') != null;
  }

  Uint8List getDecodedToken() {
    return base64Decode(_prefs.getString("token").split(" ")[1]);
  }

  Future<void> clearStorage() async {
    await _prefs.clear();
  }
}
