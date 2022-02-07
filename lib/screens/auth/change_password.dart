import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/utils/shared/custom_textformfield.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
                "Change password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Kindly enter your new password ",
                style: TextStyle(
                  fontSize: 18,
                ),
                // textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 60,
              ),
              CustomTextFormField(
                labelText: "Old password",
                obscureText: true,
              ),
              CustomTextFormField(
                labelText: "New password",
                obscureText: true,
              ),
              CustomTextFormField(
                labelText: "Confirm New password",
                obscureText: true,
              ),
              SizedBox(
                height: 120,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: RoundedRaisedButton(
                  label: "Confirm",
                  onPressed: () {
                    // Navigator.of(context).pushNamed(kRegisterPageThree);
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
