import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/utils/shared/custom_default_button.dart';
import 'package:pebbles/utils/shared/custom_textformfield.dart';
import 'package:pebbles/utils/shared/error_snackbar.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';
import 'package:get/get.dart';
import 'package:pebbles/provider/auth.dart';
import 'package:pebbles/utils/shared/top_back_navigation_widget.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = new GlobalKey<FormState>();
  bool _rememberMe = false;
  bool _isLoading = false;
  String? userEmail, userPassword;
  String errMsg = "";
  bool _obscurePassword = true;

  Future<void> _submitLogin() async {
    if (!_loginFormKey.currentState!.validate()) {
      return;
    }
    _loginFormKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .signIn(userEmail!, userPassword!);

      Navigator.of(context)
          .pushNamedAndRemoveUntil(kDashboard, (route) => false);
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
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.fill,
            ),
            color: Colors.grey.withOpacity(0.2)),
        child: SingleChildScrollView(
          child: Form(
            key: _loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //TopBackNavigationWidget(),
                SizedBox(height: 40),
                Text(
                  "Welcome Back,",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      fontFamily: 'Gilroy'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Sign into your account!",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 100,
                ),
                CustomTextFormField(
                  labelText: "Email Address",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email can't be empty";
                    }
                  },
                  onSaved: (value) {
                    userEmail = value;
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password can't be empty";
                    }
                  },
                  onSaved: (value) {
                    userPassword = value;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Did you forget your password? ",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(kResetPassword);
                      },
                      child: Text(
                        "Reset it",
                        style: TextStyle(
                            color: kAccentColor,
                            fontSize: MediaQuery.of(context).size.width / 28,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                CustomDefaultButton(
                  onPressed: () async {
                    await _submitLogin();
                  },
                  isLoading: _isLoading,
                  text: 'Login',
                ),

                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("If you have don’t have an account,",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 26,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700,
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(kCreateUserAccount);
                      },
                      child: Text(
                        " Sign Up",
                        style: TextStyle(
                            color: kAccentColor,
                            fontSize: MediaQuery.of(context).size.width / 26,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
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
                // SizedBox(
                //   height: 30,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Image.asset("assets/images/google.png"),
                //   ],
                // ),
                // SizedBox(
                //   height: 20,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
