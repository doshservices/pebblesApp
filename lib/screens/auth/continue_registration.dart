import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/http_exception.dart';
import 'package:pebbles/model/registration.dart';
import 'package:pebbles/model/user_model.dart';
import 'package:pebbles/provider/auth.dart';
import 'package:pebbles/utils/shared/custom_default_button.dart';
import 'package:pebbles/utils/shared/custom_textformfield.dart';
import 'package:pebbles/utils/shared/error_snackbar.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';
import 'package:pebbles/utils/shared/top_back_navigation_widget.dart';
import 'package:provider/provider.dart';

class ContinueRegistration extends StatefulWidget {
  @override
  _ContinueRegistrationState createState() => _ContinueRegistrationState();
}

class _ContinueRegistrationState extends State<ContinueRegistration> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey();
  final _passwordController = TextEditingController();

  UserModel userModel = UserModel();
  bool _isLoading = false;

  // validate email and send otp on submit
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

    // send otp to email
    try {
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
    final argument =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    userModel = argument["user"];

    String? userRole = userModel.role;

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
                TopBackNavigationWidget(),
                Text(
                  "Continue Registration",
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
                  "${userRole == Role_Business ? 'Business account' : 'Individual account'}",
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
                userRole == Role_Individual
                    ? CustomTextFormField(
                        labelText: "Name",
                        validator: (value) {
                          // validate name
                          if (value!.isEmpty) {
                            return "Name required";
                          }

                          // valid email
                          return null;
                        },
                        onSaved: (value) {
                          userModel.fullName = value;

                          return;
                        },
                      )
                    : Text(""),
                CustomTextFormField(
                  labelText: "Email address",
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
                  onSaved: (value) {
                    userModel.email = value;

                    return;
                  },
                ),
                userRole == Role_Business
                    ? CustomTextFormField(
                        labelText: "Company's name",
                        validator: (value) {
                          // validate name
                          if (value!.isEmpty) {
                            return "Company's name required";
                          }

                          // valid input
                          return null;
                        },
                        onSaved: (value) {
                          userModel.businessName = value;

                          return;
                        },
                      )
                    : Text(""),
                CustomTextFormField(
                  labelText: "Phone number",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Phone number required";
                    }

                    return null;
                  },
                  onSaved: (value) {
                    userModel.phoneNumber = value;
                  },
                ),
                CustomTextFormField(
                  labelText: "Password",
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password can't be empty";
                    }

                    if (value.length < 6) {
                      return "Password length should be greater than 5";
                    }
                    return null;
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
                SizedBox(
                  height: 60,
                ),
                CustomDefaultButton(
                  onPressed: _submit,
                  text: 'Proceed',
                  isLoading: _isLoading,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
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
                        Navigator.of(context).pushNamed(kLogin);
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
