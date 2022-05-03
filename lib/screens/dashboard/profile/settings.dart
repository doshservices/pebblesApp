import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/user_model.dart';
import 'package:pebbles/provider/auth.dart';
import 'package:pebbles/utils/shared/top_back_navigation_widget.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Auth auth = Auth();

  Future<bool> _onBackPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Logout",
          style: TextStyle(
            color: Colors.red.shade400,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          "Are you sure you want to logout?",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            child: Text("NO"),
            onPressed: () {
              return Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: Text(
              "YES",
              style: TextStyle(color: Colors.red.shade400),
            ),
            onPressed: () {
              auth.logout();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(kLogin, (route) => false);

              return;
            },
          ),
        ],
      ),
    );

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    auth = Provider.of<Auth>(context);

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
                leading: Icon(
                  Icons.settings,
                  size: 28,
                  color: Theme.of(context).primaryColor,
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
                    SettingsItems(
                      text: 'Edit profile',
                      imageIcon: Icon(
                        Icons.edit_outlined,
                        size: 28,
                        color: Theme.of(context).primaryColor,
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(kEditProfile);
                      },
                    ),
                    SettingsItems(
                      text: 'Reset password',
                      imageIcon: Icon(
                        Icons.password_outlined,
                        size: 28,
                        color: Theme.of(context).primaryColor,
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(kChangePassword);
                      },
                    ),
                    SettingsItems(
                      text: 'Help & support',
                      imageIcon: Icon(
                        Icons.help_outline_outlined,
                        size: 28,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SettingsItems(
                      text: 'Privacy policy',
                      imageIcon: Icon(
                        Icons.privacy_tip_outlined,
                        size: 28,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SettingsItems(
                      text: 'Terms & conditions',
                      imageIcon: Icon(
                        Icons.indeterminate_check_box_outlined,
                        size: 28,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SettingsItems(
                      text: 'Logout',
                      imageIcon: Icon(
                        Icons.logout_outlined,
                        size: 28,
                        color: Theme.of(context).primaryColor,
                      ),
                      onTap: _onBackPressed,
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
  final Widget? imageIcon;
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
          leading: imageIcon,
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
