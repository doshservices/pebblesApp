import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pebbles/constants.dart';

class DialogWidgets {
  /// displays center loading dialog
  Future<dynamic> showCenterLoadingDialog({String? title}) {
    return Get.defaultDialog(
        barrierDismissible: false,
        title: title ?? 'Loading..',
        backgroundColor: Colors.white,
        radius: 10,
        content: const SizedBox(
            width: 30,
            height: 30,
            child: Center(
                child: CircularProgressIndicator(color: kPrimaryColor))));
  }
}
