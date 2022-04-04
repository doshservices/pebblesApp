import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services {
  static Future<String> getUserToken() async {
    final preferences = await SharedPreferences.getInstance();
    final userPreferences = preferences.getString("userData");
    final userJsonData = json.decode(userPreferences!);

    final userToken = userJsonData["token"];

    return userToken;
  }

  static NumberFormat currency(context) {
    Locale locale = Localizations.localeOf(context);
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');

    return format;
  }
}
