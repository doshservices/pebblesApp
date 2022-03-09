import 'package:get/get.dart';
import 'package:flutter/material.dart';

/// Displays error alert animating from top screen.
///
/// call ErrorSnackbar.displaySnackBar(text, message) to use
class ErrorSnackBar {
  static dynamic displaySnackBar(String text, String message) {
    return Get.snackbar(text, message,
        titleText: Text(
          text,
          style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 21,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        messageText: Text(
          message,
          style: TextStyle(
              fontFamily: 'Gilroy', fontSize: 17, color: Colors.white),
        ),
        barBlur: 0,
        dismissDirection: DismissDirection.vertical,
        backgroundColor: Colors.red[400],
        overlayBlur: 0,
        animationDuration: Duration(milliseconds: 500),
        duration: Duration(seconds: 3));
  }
}
