import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.all(20),
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
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/pics.png"),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Lola Rae",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 60.0),
              child: Divider(),
            ),
            ListTile(
              leading: Image.asset(
                "assets/images/image.png",
                width: 40,
              ),
              title: Text("Profile"),
              onTap: () {
                Navigator.of(context).pushNamed(kProfile);
              },
            ),
            ListTile(
              leading: Image.asset(
                "assets/images/image.png",
                width: 40,
              ),
              title: Text("Bookings and Reservations"),
              onTap: () {
                Navigator.of(context).pushNamed(kBookings);
              },
            ),
            ListTile(
              leading: Image.asset(
                "assets/images/image.png",
                width: 40,
              ),
              title: Text("List homes and Events"),
              onTap: () {
                Navigator.of(context).pushNamed(kListOptions);
              },
            ),
            ListTile(
              leading: Image.asset(
                "assets/images/image.png",
                width: 40,
              ),
              title: Text("My Apartments"),
              onTap: () {
                Navigator.of(context).pushNamed(kMyApartments);
              },
            ),
            ListTile(
              leading: Image.asset(
                "assets/images/image.png",
                width: 40,
              ),
              title: Text("My Events"),
              onTap: () {
                Navigator.of(context).pushNamed(kMyEvents);
              },
            ),
            ListTile(
              leading: Image.asset(
                "assets/images/image.png",
                width: 40,
              ),
              title: Text("Withdrawal"),
              onTap: () {
                Navigator.of(context).pushNamed(kWithdrawFunds);
              },
            ),
            ListTile(
              leading: Image.asset(
                "assets/images/image.png",
                width: 40,
              ),
              title: Text("Adds-on"),
            ),
            ListTile(
              leading: Image.asset(
                "assets/images/image.png",
                width: 40,
              ),
              title: Text("Settings"),
            ),
            ListTile(
              leading: Image.asset(
                "assets/images/image.png",
                width: 40,
              ),
              title: Text("Terms & Conditions"),
            ),
            ListTile(
              leading: Image.asset(
                "assets/images/image.png",
                width: 40,
              ),
              title: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
