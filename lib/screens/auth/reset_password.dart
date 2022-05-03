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

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String? email;
  bool _isLoading = false;

  resetPasswordSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).forgotPassword(email!);

      BottomSheets.modalBottomSheet(
          context: context,
          title: 'Success',
          subtitle: 'A token has been sent to your email',
          buttonText: 'Reset password',
          onPressed: () =>
              Navigator.of(context).pushNamed(kConfirmResetPassword));
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
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Reset Password",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Gilroy'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Please input your email, a link will be sent to you shortly to create a new password",
                  style: TextStyle(fontSize: 18, fontFamily: 'Gilroy'),
                  // textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 60,
                ),
                CustomTextFormField(
                  labelText: "Email Address",
                  onSaved: (value) {
                    email = value;

                    return;
                  },
                  validator: (value) {
                    // validate email
                    if (value!.isEmpty) {
                      return "Email required";
                    }

                    // using regular expression
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return "Please enter a valid email address";
                    }

                    // valid email
                    return null;
                  },
                ),
                SizedBox(
                  height: 120,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: CustomDefaultButton(
                      text: "Change",
                      isLoading: _isLoading,
                      onPressed: resetPasswordSubmit),
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
