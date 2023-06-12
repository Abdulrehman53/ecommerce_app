import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';





class PrefManager {
  static final PrefManager _singleton = PrefManager._internal();

  factory PrefManager() {
    return _singleton;
  }

  PrefManager._internal();

  Future<String> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getString(key)!=null ){
    return json.decode(prefs.getString(key)!);
    }
    return '';
  }

  Future save(String key, value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(key, json.encode(value));
    } catch (ex) {
      print(ex);
    }
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

 /*  Future<UserDataModel> getUserInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey(AppKeys.USER_INFO)) {
        var model = await read(AppKeys.USER_INFO);
        UserDataModel userModel = UserDataModel.fromJson(model);
        return userModel;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey(AppKeys.USER_INFO)) {
         await remove(AppKeys.USER_INFO);

      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> isAppRunFirstTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey(AppKeys.IS_FIRST_TIME)) {
        bool isFistTime = await read(AppKeys.IS_FIRST_TIME);
        return isFistTime;
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  } */
}
