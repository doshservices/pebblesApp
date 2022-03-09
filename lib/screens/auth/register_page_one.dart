import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/utils/shared/custom_default_button.dart';

class RegisterPageOne extends StatefulWidget {
  @override
  _RegisterPageOneState createState() => _RegisterPageOneState();
}

class _RegisterPageOneState extends State<RegisterPageOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill),
            color: Colors.grey.withOpacity(0.2)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Text(
                "Create an account",
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
                "How will you like to be registered?",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 120,
              ),
              CustomDefaultButton(
                text: 'Host',
                onPressed: () {
                  Navigator.of(context).pushNamed(kRegisterHost);
                },
              ),
              SizedBox(
                height: 30,
              ),
              CustomDefaultButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(kCreateUserAccount);
                  },
                  text: 'User'),
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
    );
  }
}
