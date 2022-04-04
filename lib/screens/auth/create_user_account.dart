import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/user_model.dart';
import 'package:pebbles/utils/shared/custom_default_button.dart';
import 'package:pebbles/utils/shared/custom_textformfield.dart';
import 'package:pebbles/utils/shared/error_snackbar.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';
import 'package:get/get.dart';
import 'package:pebbles/model/http_exception.dart';
import 'package:pebbles/utils/shared/top_back_navigation_widget.dart';
import 'package:provider/provider.dart';
import 'package:pebbles/provider/auth.dart';

class CreateUserAccount extends StatefulWidget {
  @override
  _CreateUserAccountState createState() => _CreateUserAccountState();
}

class _CreateUserAccountState extends State<CreateUserAccount> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey();

  final _passwordController = TextEditingController();

  UserModel userModel = UserModel();
  bool _termsAndCondition = false;
  TextEditingController _date = new TextEditingController();
  bool agree = false;

  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();

    if (!_registerFormKey.currentState!.validate()) {
      // invalid input fields
      ErrorSnackBar.displaySnackBar(
          'Error!', 'Please complete the missing fields');

      return;
    }
    _registerFormKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      userModel.role = Role_User;
      await Provider.of<Auth>(context, listen: false).sendOtp(userModel.email!);
      Navigator.of(context)
          .pushNamed(kOtpVerification, arguments: {"user": userModel});
    } on HttpException catch (error) {
      // registration failed, display alert
      ErrorSnackBar.displaySnackBar('Error!', '${error.toString()}');
    } catch (error) {
      // encountered error
      ErrorSnackBar.displaySnackBar(
          'Error!', 'Registration failed, please try again later');
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
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.fill,
            ),
            color: Colors.grey.withOpacity(0.2)),
        child: SingleChildScrollView(
          child: Form(
            key: _registerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 45),
                //TopBackNavigationWidget(),

                Text(
                  "Register your account",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      fontFamily: 'Gilroy'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "User",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  labelText: "Name",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name required";
                    }
                  },
                  onSaved: (value) {
                    userModel.fullName = value;
                  },
                ),
                CustomTextFormField(
                  labelText: "Email address",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email required";
                    }

                    // using regular expression
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    userModel.email = value;
                  },
                ),
                CustomTextFormField(
                  labelText: "Phone number",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Phone number required";
                    }
                  },
                  onSaved: (value) {
                    userModel.phoneNumber = value;
                  },
                ),
                CustomTextFormField(
                  labelText: "Password",
                  icon: _obscurePassword
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility_rounded),
                  obscureText: _obscurePassword,
                  iconPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password can't be empty";
                    }
                  },
                  onSaved: (value) {
                    userModel.password = value;
                  },
                ),
                CustomTextFormField(
                  labelText: "Confirm password",
                  icon: _obscurePassword
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility_rounded),
                  obscureText: _obscurePassword,
                  iconPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  validator: (value) {
                    if (_passwordController.text != value) {
                      return "Password not the same";
                    }
                  },
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       "Or Via",
                //       style: TextStyle(
                //           color: Theme.of(context).primaryColor,
                //           fontWeight: FontWeight.bold),
                //     ),
                //   ],
                // ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Image.asset("assets/images/google.png"),
                //   ],
                // ),
                SizedBox(
                  height: 35,
                ),

                // submit button
                CustomDefaultButton(
                    onPressed: _submit, text: 'Proceed', isLoading: _isLoading),

                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "If you have an account, ",
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed(kLogin);
                        },
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            color: kAccentColor,
                            fontSize: 17,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
