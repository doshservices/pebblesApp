import 'package:flutter/material.dart';
import 'package:pebbles/bloc/services.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/user_model.dart';
import 'package:pebbles/provider/auth.dart';
import 'package:pebbles/utils/shared/bottom_sheets.dart';
import 'package:pebbles/utils/shared/custom_default_button.dart';
import 'package:pebbles/utils/shared/custom_textformfield.dart';
import 'package:pebbles/utils/shared/error_snackbar.dart';
import 'package:pebbles/utils/shared/top_back_navigation_widget.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String? oldPassword;
  String? newPassword;
  String? confirmNewPassword;
  UserModel userProfile = UserModel();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  bool _isLoading = false;

  changePasswordSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (userProfile.password != oldPassword) {
        throw "Invalid password";
      }

      await Provider.of<Auth>(context, listen: false)
          .forgotPassword(userProfile.email!);

      BottomSheets.modalBottomSheet(
          context: context,
          title: 'Success',
          subtitle: 'A token has been sent to your email',
          buttonText: 'Reset password',
          onPressed: () => Navigator.of(context).pushNamed(
              kConfirmResetPassword,
              arguments: true)); // true : i.e user is logged in
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
    userProfile = Services.getUserProfile(context);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover),
            color: Colors.grey.withOpacity(0.2)),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopBackNavigationWidget(),
                Text(
                  "Change password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Validate your identity",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                CustomTextFormField(
                  labelText: "Password",
                  obscureText: true,
                  onSaved: (value) {
                    oldPassword = value;

                    return;
                  },
                  validator: (value) {
                    // validate input
                    if (value!.isEmpty) {
                      return "Field required";
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
                      text: "Confirm",
                      isLoading: _isLoading,
                      onPressed: changePasswordSubmit),
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
