import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/provider/auth.dart';
import 'package:pebbles/utils/shared/bottom_sheets.dart';
import 'package:pebbles/utils/shared/custom_default_button.dart';
import 'package:pebbles/utils/shared/custom_textformfield.dart';
import 'package:pebbles/utils/shared/error_snackbar.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';
import 'package:pebbles/utils/shared/top_back_navigation_widget.dart';
import 'package:provider/provider.dart';

class ConfirmResetPassword extends StatefulWidget {
  @override
  _ConfirmResetPasswordState createState() => _ConfirmResetPasswordState();
}

class _ConfirmResetPasswordState extends State<ConfirmResetPassword> {
  String? token;
  String? password;
  String? confirmPassword;
  bool _isLoading = false;

  /// true if user is navigating from change password screen
  bool? changePassword = false;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  submitResetPassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .forgotPasswordCompletion(token!, password!);

      BottomSheets.modalBottomSheet(
          context: context,
          title: 'Success',
          subtitle: 'Password reset successful',
          buttonText: changePassword! ? 'Back to settings' : null,
          onPressed: changePassword!
              ? () => Navigator.of(context).pushNamedAndRemoveUntil(
                  KSettings, (Route<dynamic> route) => false)
              : null);
    } catch (error) {
      ErrorSnackBar.displaySnackBar('Error', '${error.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    changePassword = ModalRoute.of(context)?.settings.arguments as bool?;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill),
            color: Colors.grey.withOpacity(0.2)),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopBackNavigationWidget(),
                Text(
                  "Reset password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Kindly enter email token and your new password ",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  // textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 60,
                ),
                CustomTextFormField(
                  labelText: "Email token",
                  obscureText: true,
                  onSaved: (value) {
                    token = value;

                    return;
                  },
                  onChanged: (value) {
                    token = value;
                    return;
                  },
                  validator: (value) {
                    // validate input
                    if (value!.isEmpty) {
                      return "Token required";
                    }

                    return null;
                  },
                ),
                CustomTextFormField(
                  labelText: "New password",
                  obscureText: true,
                  onSaved: (value) {
                    password = value;

                    return;
                  },
                  onChanged: (value) {
                    password = value;
                  },
                  validator: (value) {
                    // validate input
                    if (value!.isEmpty) {
                      return "Password required";
                    }

                    return null;
                  },
                ),
                CustomTextFormField(
                  labelText: "Confirm New password",
                  obscureText: true,
                  onSaved: (value) {
                    confirmPassword = value;

                    return;
                  },
                  validator: (value) {
                    // validate input
                    if (value!.isEmpty) {
                      return "Confirm password";
                    }

                    if (value != password) {
                      return "Confirmation password does not match";
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: 120,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: CustomDefaultButton(
                      isLoading: _isLoading,
                      text: "Confirm",
                      onPressed: submitResetPassword),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
