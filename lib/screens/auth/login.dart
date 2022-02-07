import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/utils/shared/custom_textformfield.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';
import 'package:get/get.dart';
import 'package:pebbles/provider/auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = new GlobalKey<FormState>();
  bool _rememberMe = false;
  bool _isLoading = false;
  String userEmail, userPassword;
  String errMsg = "";
  bool _obscurePassword = true;

  Future<void> _submitLogin() async {
    if (!_loginFormKey.currentState.validate()) {
      return;
    }
    _loginFormKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .signIn(userEmail, userPassword);

      Navigator.of(context)
          .pushNamedAndRemoveUntil(kDashboard, (route) => false);
    } catch (error) {
      Get.snackbar('Error!', '${error.toString()}',
          barBlur: 0,
          dismissDirection: SnackDismissDirection.VERTICAL,
          backgroundColor: Colors.red,
          overlayBlur: 0,
          animationDuration: Duration(milliseconds: 500),
          duration: Duration(seconds: 2));
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
            ),
            color: Colors.grey.withOpacity(0.2)),
        child: SingleChildScrollView(
          child: Form(
            key: _loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                          ),
                          Text("Back"),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Welcome Back,",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Sign into your account!",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 100,
                ),
                CustomTextFormField(
                  labelText: "Email Address",
                  validator: (value) {
                    if (value.isEmpty) {
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
                    if (value.isEmpty) {
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
                    Text("Did you forget your password? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(kResetPassword);
                      },
                      child: Text(
                        "Reset it",
                        style: TextStyle(color: kAccentColor),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: RoundedRaisedButton(
                    label: "Login",
                    isLoading: _isLoading,
                    onPressed: () async {
                      await _submitLogin();
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("If you have don’t have an account,"),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(kCreateUserAccount);
                      },
                      child: Text(
                        " Sign Up",
                        style: TextStyle(color: kAccentColor),
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
