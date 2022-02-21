import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pebbles/screens/dashboard/widgets/top_back_navigation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/provider/booking_api.dart';
import 'package:pebbles/model/booking_model.dart';
import 'package:pebbles/model/registration.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';

class Bookings extends StatefulWidget {
  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  //List<Booking> _bookingsDataList = [];
  // BookingAPI bookingAPI = BookingAPI(token: "");
  BookingModel _bookingModel = BookingModel();

  Future<BookingModel> getCurrentUserBookings() async {
    final preferences = await SharedPreferences.getInstance();
    final userPreferences = preferences.getString("userData");
    final userJsonData = json.decode(userPreferences);

    final userToken = userJsonData["token"];

    // api request to get current user bookings
    BookingAPI bookingAPI = BookingAPI(token: userToken);
    _bookingModel = await bookingAPI.getBookingByUserId();

    return _bookingModel;
  }

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
        child: Expanded(
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
                height: 20,
              ),
              FutureBuilder(
                future: getCurrentUserBookings(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (_bookingModel.status == 'error') {
                      return Expanded(
                          child: Column(
                        children: [
                          Center(
                              child: Text(
                            'Could not get bookings data',
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w900,
                                fontSize: 23.0),
                          ))
                        ],
                      ));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.data.bookings.length,
                        itemBuilder: (context, index) {
                          return BookingsItem(
                              bookingData: _bookingModel.data.bookings[index]);
                        },
                      );
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Expanded(
                      child: Column(
                        children: [LinearProgressIndicator()],
                      ),
                    );
                  }

                  return Column();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingsItem extends StatelessWidget {
  final Booking bookingData;

  BookingsItem({Key key, this.bookingData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(1),
            child: Image(image: AssetImage("assets/images/hotel.png")),
          ),
          contentPadding: EdgeInsets.all(0),
          title: Text(
            '${bookingData.apartmentId.apartmentName}',
            style: TextStyle(
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w900,
                fontSize: 23.0),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 7.0),
            child: Text(
              "Victoria Island, Lagos.",
              style: TextStyle(fontFamily: 'Gilroy', fontSize: 16.0),
            ),
          ),
          trailing: Image.asset(
            "assets/images/arrowforward.png",
            width: 40,
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(kBookingsDetail, arguments: bookingData);
          },
        ),
        Divider()
      ],
    );
  }
}
