import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/utils/shared/custom_default_button.dart';

class BottomSheets {
  static modalBottomSheet(
      {required BuildContext context,
      String? assetImageURL,
      String? title,
      String? subtitle,
      bool showButton = true,
      String? buttonText,
      bool isDismissible = false,
      Function()? onPressed}) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isDismissible: isDismissible,
        context: context,
        builder: (ctx) {
          return Container(
            //margin: EdgeInsets.only(top: 40),
            padding: EdgeInsets.only(bottom: 30.0, top: 30.0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
            ),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0),
                child: Image(
                  image:
                      AssetImage(assetImageURL ?? "assets/images/verified.png"),
                  height: MediaQuery.of(context).size.height / 10,
                  fit: BoxFit.contain,
                ),
              ),
              // app name
              Text(
                title ?? "Account Verified",
                style: TextStyle(
                    color: Color(0xFF4368B2),
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                    fontFamily: 'Gilroy'),
              ),
              // Text desc
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  subtitle ?? "Account has been successfully created",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Gilroy'),
                ),
              ),
              SizedBox(height: 30),
              // button
              showButton
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: CustomDefaultButton(
                        onPressed: onPressed ??
                            () {
                              // Navigate to homePage and remove previously stacked screen
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  kLogin, (Route<dynamic> route) => false);
                            },
                        text: buttonText ?? 'Login',
                      ),
                    )
                  : SizedBox(height: 1),
            ]),
          );
        });
  }
}
