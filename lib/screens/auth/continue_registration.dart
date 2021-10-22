import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/registration.dart';
import 'package:pebbles/utils/shared/custom_textformfield.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';

class ContinueRegistration extends StatefulWidget {
  @override
  _ContinueRegistrationState createState() => _ContinueRegistrationState();
}

class _ContinueRegistrationState extends State<ContinueRegistration> {
  @override
  Widget build(BuildContext context) {
    final argument =
        ModalRoute.of(context).settings.arguments as Map<String, Registration>;
    Registration reg = argument["reg"];
    String subType = reg.subType;
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
                "Continue Registration",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  "${subType == 'business' ? 'Business account' : 'Individual account'}",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline,
                  )),
              SizedBox(
                height: 20,
              ),
              subType == "individual"
                  ? CustomTextFormField(
                      labelText: "Name",
                    )
                  : Text(""),
              CustomTextFormField(
                labelText: "Email address",
              ),
              subType == "individual"
                  ? CustomTextFormField(
                      labelText: "Phone number",
                    )
                  : Text(""),
              CustomTextFormField(
                labelText: "Password",
              ),
              CustomTextFormField(
                labelText: "Confirm password",
              ),
              subType == "business"
                  ? CustomTextFormField(
                      labelText: "Contact person",
                    )
                  : Text(""),

              subType == "business"
                  ? CustomTextFormField(
                      labelText: "Company's name",
                    )
                  : Text(""),

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
                  onPressed: () {
                    Navigator.of(context).pushNamed(kCompleteRegistration,
                        arguments: {...argument});
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
                  Text(
                    "Log in",
                    style: TextStyle(color: kAccentColor),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
