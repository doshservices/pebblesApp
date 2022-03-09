import 'package:flutter/material.dart';

class CustomDefaultButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool isLoading;
  final String text;
  // true : uses default gradient with primary color
  // false : uses plain white color
  final bool isPrimaryButton;

  CustomDefaultButton(
      {Key? key,
      this.onPressed,
      this.text = '',
      this.isLoading = false,
      this.isPrimaryButton = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 55.0,
        // alignment: Alignment.center,
        decoration: BoxDecoration(
          // true : uses default gradient with primary color
          // false : uses plain white color
          color: Colors.white,
          gradient: isPrimaryButton
              ? LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.9),
                    Theme.of(context).primaryColor.withOpacity(0.7)
                    // Color.fromRGBO(0, 52, 154, 0.9),
                    // Color.fromRGBO(0, 52, 154, 0.7)
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Stack(
            children: [
              // displays 'Proceed' text by default
              Visibility(
                visible: isLoading ? false : true,
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.bold,
                      color: isPrimaryButton
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              // display loader after button is clicked
              Visibility(
                visible: isLoading ? true : false,
                child: Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(
                      color: isPrimaryButton
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                    ),
                    width: 30.0,
                    height: 30.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 0.0,
          vertical: 8.0,
        ),
      ),
    );
  }
}
