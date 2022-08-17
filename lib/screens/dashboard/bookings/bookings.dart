import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';

class Bookings extends StatefulWidget {
  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
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
              ListTile(
                leading: Image.asset(
                  "assets/images/image.png",
                  width: 40,
                ),
                contentPadding: EdgeInsets.all(0),
                title: Text("Bookings & Reservations"),
              ),
              SizedBox(
                height: 20,
              ),
              BookingsItem(),
              BookingsItem(),
              BookingsItem(),
              BookingsItem(),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingsItem extends StatelessWidget {
  const BookingsItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Image.asset(
            "assets/images/hotel.png",
            width: 40,
          ),
          contentPadding: EdgeInsets.all(0),
          title: Text("Cubana Victoria Island"),
          subtitle: Text("Victoria Island, Lagos."),
          trailing: Image.asset(
            "assets/images/arrowforward.png",
            width: 40,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(kBookingsDetail);
          },
        ),
        Divider()
      ],
    );
  }
}
