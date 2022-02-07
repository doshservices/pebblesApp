import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/registration.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';

class BookingsDetails extends StatefulWidget {
  @override
  _BookingsDetailsState createState() => _BookingsDetailsState();
}

class _BookingsDetailsState extends State<BookingsDetails> {
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
                height: 50,
              ),
              BookingsDetailItem(),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingsDetailItem extends StatelessWidget {
  const BookingsDetailItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            ListTile(
              // leading: Image.asset(
              //   "assets/images/hotel.png",
              //   width: 40,
              // ),
              contentPadding: EdgeInsets.all(0),
              title: Text("Check-in  date"),
              // subtitle: Text("Victoria Island, Lagos."),
              trailing: Text(
                "19/11/2021",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Divider(),
            ListTile(
              // leading: Image.asset(
              //   "assets/images/hotel.png",
              //   width: 40,
              // ),
              contentPadding: EdgeInsets.all(0),
              title: Text("Check-out  date"),
              // subtitle: Text("Victoria Island, Lagos."),
              trailing: Text(
                "26/11/2021",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Divider(),
            ListTile(
              // leading: Image.asset(
              //   "assets/images/hotel.png",
              //   width: 40,
              // ),
              contentPadding: EdgeInsets.all(0),
              title: Text("Adds-on"),
              // subtitle: Text("Victoria Island, Lagos."),
              trailing: Image.asset(
                "assets/images/accept.png",
                width: 40,
              ),
            ),
            Divider(),
            ListTile(
              // leading: Image.asset(
              //   "assets/images/hotel.png",
              //   width: 40,
              // ),
              contentPadding: EdgeInsets.all(0),
              title: Text("No. of  guest"),
              // subtitle: Text("Victoria Island, Lagos."),
              trailing: Text(
                "5",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
