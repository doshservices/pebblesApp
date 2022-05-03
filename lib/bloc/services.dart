import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:pebbles/model/user_model.dart';
import 'package:pebbles/provider/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services {
  static Future<String> getUserToken() async {
    final preferences = await SharedPreferences.getInstance();
    final userPreferences = preferences.getString("userData");
    final userJsonData = json.decode(userPreferences!);

    final userToken = userJsonData["token"];

    return userToken;
  }

  static UserModel getUserProfile(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    UserModel user = auth.user;

    return user;
  }
}
