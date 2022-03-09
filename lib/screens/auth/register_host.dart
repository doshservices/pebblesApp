import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/registration.dart';
import 'package:pebbles/model/user_model.dart';
import 'package:pebbles/utils/shared/custom_default_button.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';
import 'package:pebbles/utils/shared/top_back_navigation_widget.dart';

class RegisterHost extends StatefulWidget {
  @override
  _RegisterHostState createState() => _RegisterHostState();
}

class _RegisterHostState extends State<RegisterHost> {
  UserModel userModel = new UserModel();

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
                height: 15,
              ),
              Text(
                "Register as an host account",
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
                onPressed: () {
                  userModel.role = Role_Business;

                  Navigator.of(context).pushNamed(kContinueRegistration,
                      arguments: {"user": userModel});
                },
                text: 'Business',
              ),
              SizedBox(
                height: 30,
              ),
              CustomDefaultButton(
                onPressed: () {
                  userModel.role = Role_Individual;
                  Navigator.of(context).pushNamed(kContinueRegistration,
                      arguments: {"user": userModel});
                },
                text: 'Individual',
                isPrimaryButton: false,
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
    );
  }
}
