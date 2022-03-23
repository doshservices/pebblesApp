import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/registration.dart';
import 'package:pebbles/model/user_model.dart';
import 'package:pebbles/provider/auth.dart';
import 'package:pebbles/utils/shared/custom_default_button.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';
import 'package:pebbles/utils/shared/top_back_navigation_widget.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserModel user = UserModel();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    user = auth.user;
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
              TopBackNavigationWidget(),
              ListTile(
                leading: Image.asset(
                  "assets/images/image.png",
                  width: 40,
                ),
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  "Profile",
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  CircleAvatar(
                      backgroundImage: NetworkImage(
                        "${user.profilePhoto}",
                      ),
                      backgroundColor: Colors.grey.withOpacity(0.5)),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "${user.fullName}",
                    style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text("Personal Information",
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Full name",
                      style: TextStyle(fontFamily: 'Gilroy', fontSize: 18),
                    ),
                    Text(
                      "${user.fullName}",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Phone number",
                        style: TextStyle(fontFamily: 'Gilroy', fontSize: 18)),
                    Text(
                      "${user.phoneNumber}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gilroy',
                          fontSize: 18),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Email",
                        style: TextStyle(fontFamily: 'Gilroy', fontSize: 18)),
                    Text("${user.email}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                            fontSize: 18))
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomDefaultButton(
                    text: "Change Password",
                    onPressed: () {
                      Navigator.of(context).pushNamed(kChangePassword);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
