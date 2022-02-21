import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/user_model.dart';
import 'package:pebbles/provider/auth.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    UserModel user = auth.user;
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
            ),
            color: Colors.grey.withOpacity(0.2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(17, 10, 10, 0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "${user.profilePhoto}",
                        ),
                        backgroundColor: Colors.grey.withOpacity(0.5),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "${user.fullName}",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 21,
                          letterSpacing: 1,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 60.0),
              child: Divider(),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Image.asset(
                      "assets/images/image.png",
                      width: 40,
                    ),
                    title: Text(
                      "Profile",
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(kProfile);
                    },
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  ListTile(
                    leading: Image.asset(
                      "assets/images/image.png",
                      width: 40,
                    ),
                    title: Text(
                      "Bookings and Reservations",
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(kBookings);
                    },
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  ListTile(
                    leading: Image.asset(
                      "assets/images/image.png",
                      width: 40,
                    ),
                    title: Text(
                      "List homes and Events",
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(kListOptions);
                    },
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  ListTile(
                    leading: Image.asset(
                      "assets/images/image.png",
                      width: 40,
                    ),
                    title: Text(
                      "My Apartments",
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(kMyApartments);
                    },
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  ListTile(
                    leading: Image.asset(
                      "assets/images/image.png",
                      width: 40,
                    ),
                    title: Text(
                      "My Events",
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(kMyEvents);
                    },
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  ListTile(
                    leading: Image.asset(
                      "assets/images/image.png",
                      width: 40,
                    ),
                    title: Text(
                      "Withdrawal",
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(kWithdrawFunds);
                    },
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  ListTile(
                    leading: Image.asset(
                      "assets/images/image.png",
                      width: 40,
                    ),
                    title: Text(
                      "Adds-on",
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  ListTile(
                    leading: Image.asset(
                      "assets/images/image.png",
                      width: 40,
                    ),
                    title: Text(
                      "Settings",
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  ListTile(
                    leading: Image.asset(
                      "assets/images/image.png",
                      width: 40,
                    ),
                    title: Text(
                      "Terms & Conditions",
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  ListTile(
                    leading: Image.asset(
                      "assets/images/image.png",
                      width: 40,
                    ),
                    title: Text(
                      "Logout",
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    onTap: () {
                      auth.logout();
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil(kLogin, (route) => false);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
