import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/user_model.dart';
import 'package:pebbles/provider/auth.dart';
import 'package:pebbles/utils/shared/top_back_navigation_widget.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill),
            color: Colors.grey.withOpacity(0.2)),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBackNavigationWidget(),
              ListTile(
                leading: Image.asset(
                  "assets/images/image.png",
                  width: 40,
                ),
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Settings",
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SettingsItems(text: 'Edit profile'),
                    SettingsItems(
                      text: 'Reset password',
                      onTap: () {
                        Navigator.of(context).pushNamed(kChangePassword);
                      },
                    ),
                    SettingsItems(text: 'Help & support'),
                    SettingsItems(text: 'Privacy policy'),
                    SettingsItems(text: 'Terms & conditions'),
                    SettingsItems(
                      text: 'Logout',
                      onTap: () {
                        auth.logout();
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil(kLogin, (route) => false);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsItems extends StatelessWidget {
  final Function()? onTap;
  final String? imageIcon;
  final String? text;

  SettingsItems({Key? key, this.text, this.onTap, this.imageIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ListTile(
          leading: Image.asset(
            imageIcon ?? "assets/images/image.png",
            width: 40,
          ),
          title: Text(
            text ?? "",
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 17,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
