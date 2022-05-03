import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText, initialValue;
  final Widget? icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final int lines;
  final bool enabled;
  final void Function()? iconPressed;
  final String? Function(String?)? validator, onSaved;
  final Color? textColor;
  final InputBorder? darkInputBorder;
  final Function(String)? onChanged;

  CustomTextFormField(
      {this.labelText,
      this.icon,
      this.obscureText = false,
      this.enabled = true,
      this.initialValue,
      this.lines = 1,
      this.iconPressed,
      this.keyboardType = TextInputType.text,
      this.darkInputBorder,
      this.textColor,
      this.controller,
      this.onSaved,
      this.onChanged,
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
                  onChanged: onChanged,
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
                    labelStyle: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w700,
                    ),
                    hintStyle: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w700,
                    ),
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
                  key: Key(labelText ?? ''),
                  controller: controller,
                  onSaved: onSaved,
                  minLines: lines,
                  maxLines: lines,
                  validator: validator,
                  onChanged: onChanged,
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
                    labelStyle: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w700,
                        color: textColor),
                    hintStyle: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w700,
                    ),
                    suffixIconConstraints: BoxConstraints(minWidth: 125),
                    enabled: enabled,
                    enabledBorder: darkInputBorder,
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
