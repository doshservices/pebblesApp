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
                  padding: EdgeInsets.fromLTRB(20, 20, 10, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(kProfile);
                        },
                        child: CircleAvatar(
                          child: ClipOval(child: Icon(Icons.person)),
                          backgroundColor: Theme.of(context).primaryColorLight,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "${user.fullName?.split(' ').first ?? "user"}",
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
              padding: const EdgeInsets.only(right: 60.0, top: 10),
              child: Divider(),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.book_online_outlined,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      "Bookings and reservations",
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(kBookings);
                    },
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.event_outlined,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      "Events",
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(kMyEvents);
                    },
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.add_box_outlined,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      "Adds-on",
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
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
