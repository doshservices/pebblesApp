import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/user_model.dart';
import 'package:pebbles/utils/shared/custom_textformfield.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';
import 'package:get/get.dart';
import 'package:pebbles/model/http_exception.dart';
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
    if (!_registerFormKey.currentState.validate()) {
      Get.snackbar('Error!', 'Please complete the missing fields',
          barBlur: 0,
          dismissDirection: SnackDismissDirection.VERTICAL,
          backgroundColor: Colors.red,
          overlayBlur: 0,
          animationDuration: Duration(milliseconds: 500),
          duration: Duration(seconds: 2));
      return;
    }
    _registerFormKey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false).sendOtp(userModel.email);
      Navigator.of(context)
          .pushNamed(kOtpVerification, arguments: {"user": userModel});
    } on HttpException catch (error) {
      Get.snackbar('Error!', '${error.toString()}',
          barBlur: 0,
          dismissDirection: SnackDismissDirection.VERTICAL,
          backgroundColor: Colors.red,
          overlayBlur: 0,
          animationDuration: Duration(milliseconds: 500),
          duration: Duration(seconds: 2));
    } catch (error) {
      Get.snackbar('Error!', 'Registration Failed, Please try again later',
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
            key: _registerFormKey,
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
                  "Continue Registration",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      fontFamily: 'Gilroy'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("User",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        decoration: TextDecoration.underline,
                        fontFamily: 'Gilroy')),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  labelText: "Name",
                  validator: (value) {
                    if (value.isEmpty) {
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
                    if (value.isEmpty) {
                      return "Email required";
                    }
                  },
                  onSaved: (value) {
                    userModel.email = value;
                  },
                ),
                CustomTextFormField(
                  labelText: "Phone number",
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Phone number required";
                    }
                  },
                  onSaved: (value) {
                    userModel.phoneNumber = value;
                  },
                ),
                CustomTextFormField(
                  labelText: "Password",
                  obscureText: true,
                  // suffixIcon: _obscurePassword
                  //         ? Icon(Icons.visibility_off)
                  //         : Icon(Icons.visibility_rounded),
                  //     obscureText: _obscurePassword,
                  //     suffixIconPressed: () {
                  //       setState(() {
                  //         _obscurePassword = !_obscurePassword;
                  //       });
                  //     },
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Password can't be empty";
                    }
                  },
                  onSaved: (value) {
                    userModel.password = value;
                  },
                ),
                CustomTextFormField(
                  labelText: "Confirm password",
                  obscureText: true,
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
                  height: 60,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: RoundedRaisedButton(
                    label: "Proceed",
                    isLoading: _isLoading,
                    onPressed: () async {
                      _submit();
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("If you have an account, "),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed(kLogin);
                      },
                      child: Text(
                        "Log in",
                        style: TextStyle(color: kAccentColor),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
