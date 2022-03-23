import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Services{
  
  static Future<String> getUserToken() async {
    final preferences = await SharedPreferences.getInstance();
    final userPreferences = preferences.getString("userData");
    final userJsonData = json.decode(userPreferences!);

    final userToken = userJsonData["token"];

    return userToken;
  }
}