import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';

class RoundedRaisedButton extends StatelessWidget {
  bool isLoading;
  String label;
  Color labelColor, buttonColor;
  Function onPressed;

  RoundedRaisedButton(
      {this.label,
      this.labelColor = Colors.white,
      this.buttonColor = kPrimaryColor,
      this.onPressed,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        onPressed: isLoading ? null : onPressed,
        color: buttonColor,
        disabledColor: Theme.of(context).primaryColor.withOpacity(0.5),
        child: isLoading
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  width: 20,
                  height: 20,
                  child:
                      CircularProgressIndicator(backgroundColor: Colors.white),
                ),
              )
            : Text(
                label,
                style: TextStyle(color: labelColor),
              ),
      ),
    );
  }
}
