import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/booking_model.dart';
import 'package:pebbles/model/registration.dart';
import 'package:pebbles/screens/dashboard/widgets/top_back_navigation_widget.dart';
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
              TopBackNavigationWidget(),
              ListTile(
                leading: Image.asset(
                  "assets/images/image.png",
                  width: 40,
                ),
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  "Bookings & Reservations",
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF808080),
                  ),
                ),
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
  Booking bookingData = Booking();
  String checkinDateFormat;
  String checkoutDateFormat;

  BookingsDetailItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bookingData = ModalRoute.of(context).settings.arguments;

    DateTime checkInDate = DateTime.parse(bookingData.checkInDate);
    DateTime checkOutDate = DateTime.parse(bookingData.checkOutDate);

    checkinDateFormat = DateFormat.yMd().format(checkInDate);
    checkoutDateFormat = DateFormat.yMd().format(checkOutDate);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 30.0),
        child: Column(
          children: [
            ListTile(
              // leading: Image.asset(
              //   "assets/images/hotel.png",
              //   width: 40,
              // ),
              contentPadding: EdgeInsets.all(0),
              title: Text(
                "Check-in  date",
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800),
              ),
              // subtitle: Text("Victoria Island, Lagos."),
              trailing: Text(
                checkinDateFormat,
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Divider(),
            ListTile(
              // leading: Image.asset(
              //   "assets/images/hotel.png",
              //   width: 40,
              // ),
              contentPadding: EdgeInsets.all(0),
              title: Text(
                "Check-out  date",
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800),
              ),
              // subtitle: Text("Victoria Island, Lagos."),
              trailing: Text(
                checkoutDateFormat,
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Divider(),
            ListTile(
              // leading: Image.asset(
              //   "assets/images/hotel.png",
              //   width: 40,
              // ),
              contentPadding: EdgeInsets.all(0),
              title: Text(
                "Adds-on",
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800),
              ),
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
              title: Text(
                "No. of  guest",
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800),
              ),
              // subtitle: Text("Victoria Island, Lagos."),
              trailing: Text(
                '${bookingData.numberOfGuests}',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
