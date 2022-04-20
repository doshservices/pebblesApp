import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/http_exception.dart';
import 'package:pebbles/utils/shared/bottom_sheets.dart';
import 'package:pebbles/utils/shared/custom_default_button.dart';
import 'package:pebbles/utils/shared/custom_textformfield.dart';
import 'package:pebbles/utils/shared/error_snackbar.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';
import 'package:pebbles/utils/shared/top_back_navigation_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:pebbles/provider/auth.dart';
import 'package:pebbles/model/user_model.dart';
import 'package:provider/provider.dart';

class OtpVerificationScreen extends StatefulWidget {
  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  Map<String, dynamic> labels = {};
  final formKey = GlobalKey<FormState>();
  bool hasError = false;
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  bool _isLoading = false;
  StreamController<ErrorAnimationType>? errorController;
  bool _isDigitComplete = false;
  bool _isResendingOtp = false;
  bool _isValidatingOtp = false;
  UserModel userModel = UserModel();

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();

    if (currentText.isEmpty) {
      // invalid OTP
      ErrorSnackBar.displaySnackBar('Error!', 'Enter valid OTP');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // validate otp

      // signup current user
      await Provider.of<Auth>(context, listen: false)
          .signUp(userModel, currentText);

      BottomSheets.modalBottomSheet(context: context);
      
    } on HttpException catch (error) {
      // error on otp
      ErrorSnackBar.displaySnackBar('Error!', '${error.toString()}');
    } catch (error) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBackNavigationWidget(),
            Text(
              "Enter Token",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  fontFamily: 'Gilroy'),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "A 6-digits pin has been sent to your email address, enter it below to continue",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Code verification",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1),
            ),
            PinCodeTextField(
              appContext: context,
              pastedTextStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),

              length: 6,
              obscureText: false,
              obscuringCharacter: '*',
              blinkWhenObscuring: true,
              animationType: AnimationType.fade,
              validator: (v) {
                // if (v.length < 6) {
                //   setState(() {
                //     _isDigitComplete = false;
                //   });
                // } else {
                //   return null;
                // }
                return '';
              },
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                inactiveColor: Colors.grey,
                borderRadius: BorderRadius.circular(15),
                inactiveFillColor: Colors.transparent,
                selectedFillColor: Color(0xffF0F3F6),
                selectedColor: Theme.of(context).primaryColor,
                activeColor: Theme.of(context).primaryColor,
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: hasError ? Colors.grey : Colors.white,
              ),
              cursorColor: Colors.black,
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: Colors.white10,
              enableActiveFill: true,
              errorAnimationController: errorController,
              controller: textEditingController,
              keyboardType: TextInputType.number,

              // boxShadows: [
              //   BoxShadow(
              //     offset: Offset(0, 1),
              //     color: Colors.black12,
              //     blurRadius: 10,
              //   )
              // ],
              onCompleted: (v) async {
                print("Completed");
                setState(() {
                  _isDigitComplete = true;
                });
                // await signup(context);
              },
              // onTap: () {
              //   print("Pressed");
              // },
              onChanged: (value) {
                print(value);
                setState(() {
                  currentText = value;
                });
                if (value.length < 6) {
                  setState(() {
                    _isDigitComplete = false;
                  });
                }
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _isResendingOtp
                      ? null
                      : () async {
                          try {
                            setState(() {
                              _isResendingOtp = true;
                            });
                            await Provider.of<Auth>(context, listen: false)
                                .sendOtp(userModel.email!);
                          } catch (error) {
                            ErrorSnackBar.displaySnackBar(
                                'Error!', '${error.toString()}');
                          } finally {
                            setState(() {
                              _isResendingOtp = false;
                            });
                          }
                        },
                  child: _isResendingOtp
                      ? Row(
                          children: [
                            Container(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                    //color: Colors.white,
                                    )),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Resending Otp",
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          "Resend Otp",
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1),
                        ),
                ),
              ],
            ),
            Expanded(child: Container()),
            CustomDefaultButton(
                text: 'Continue', isLoading: _isLoading, onPressed: _submit),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
