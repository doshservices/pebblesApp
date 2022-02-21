import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/registration.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';

class RegisterPageTwo extends StatefulWidget {
  @override
  _RegisterPageTwoState createState() => _RegisterPageTwoState();
}

class _RegisterPageTwoState extends State<RegisterPageTwo> {
  @override
  Widget build(BuildContext context) {
    final argument =
        ModalRoute.of(context)!.settings.arguments as Map<String, Registration>;
    Registration? reg = argument["reg"];
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
                "Create an account",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Register as an host account",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 120,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: RoundedRaisedButton(
                  label: "Business",
                  onPressed: () {
                    reg!.subType = "business";

                    Navigator.of(context)
                        .pushNamed(kRegisterPageThree, arguments: {"reg": reg});
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: RoundedRaisedButton(
                  label: "Individual",
                  buttonColor: Colors.white,
                  labelColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    reg!.subType = "individual";
                    Navigator.of(context)
                        .pushNamed(kRegisterPageThree, arguments: {"reg": reg});
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
