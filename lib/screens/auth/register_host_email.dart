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

class RegisterHostEmail extends StatefulWidget {
  @override
  _RegisterHostEmailState createState() => _RegisterHostEmailState();
}

class _RegisterHostEmailState extends State<RegisterHostEmail> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey();

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
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    userModel = arguments["user"];

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            key: _registerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopBackNavigationWidget(),
                Text(
                  "Create an account",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      fontFamily: 'Gilroy'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 120,
                ),
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
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Or Via",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gilroy'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/google.png"),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                CustomDefaultButton(
                  onPressed: _submit,
                  text: 'Proceed',
                  isLoading: _isLoading,
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
