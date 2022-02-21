import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  String? labelText, initialValue;
  Widget? icon;
  bool obscureText;
  TextInputType keyboardType;
  TextEditingController? controller;
  int lines;
  bool enabled;
  final void Function()? iconPressed;
  final String? Function(String?)? validator, onSaved;

  CustomTextFormField(
      {this.labelText,
      this.icon,
      this.obscureText = false,
      this.enabled = true,
      this.initialValue,
      this.lines = 1,
      this.iconPressed,
      this.keyboardType = TextInputType.text,
      this.controller,
      this.onSaved,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(left: 0.0),
        //   child: Text(
        //     "$labelText",
        //     style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        Container(
          // height: lines > 1 ? 80 : 55,
          padding: EdgeInsets.only(bottom: 20),
          child: icon != null
              ? TextFormField(
                  key: Key(labelText!),
                  controller: controller,
                  onSaved: onSaved,
                  initialValue: initialValue,
                  validator: validator,
                  minLines: lines,
                  maxLines: lines,
                  keyboardType: keyboardType,
                  obscureText: this.obscureText,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: this.icon!,
                      onPressed: this.iconPressed,
                    ),
                    suffixIconConstraints: BoxConstraints(minWidth: 25),
                    labelText: labelText,
                    // border: InputBorder.none,
                    enabled: enabled,
                    // hintText: labelText,
                    // contentPadding: EdgeInsets.all(15),
                    // disabledBorder: InputBorder.none,
                    // enabledBorder: InputBorder.none,
                    // errorBorder: InputBorder.none,
                    // focusedBorder: InputBorder.none,
                    // focusedErrorBorder: InputBorder.none
                  ),
                )
              : TextFormField(
                  key: Key(labelText!),
                  controller: controller,
                  onSaved: onSaved,
                  minLines: lines,
                  maxLines: lines,
                  validator: validator,
                  initialValue: initialValue,
                  keyboardType: keyboardType,
                  obscureText: this.obscureText,
                  decoration: InputDecoration(
                    // suffixIcon: IconButton(
                    //   icon: this.icon,
                    //   onPressed: this.iconPressed,
                    // ),
                    // border: InputBorder.none,
                    // contentPadding: EdgeInsets.all(15),
                    labelText: labelText,
                    labelStyle: TextStyle(fontSize: 16),
                    hintStyle: TextStyle(fontSize: 16),
                    suffixIconConstraints: BoxConstraints(minWidth: 125),
                    enabled: enabled,
                    // hintText: labelText,
                    // disabledBorder: InputBorder.none,
                    // enabledBorder: InputBorder.none,
                    // errorBorder: InputBorder.none,
                    // focusedBorder: InputBorder.none,
                    // focusedErrorBorder: InputBorder.none
                  ),
                ),
        ),
      ],
    );
  }
}
