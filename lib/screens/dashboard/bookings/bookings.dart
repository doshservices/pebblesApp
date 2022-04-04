import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pebbles/utils/shared/top_back_navigation_widget.dart';
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
  BookingModel _bookingModel = BookingModel();

  Future<BookingModel> getCurrentUserBookings() async {
    final preferences = await SharedPreferences.getInstance();
    final userPreferences = preferences.getString("userData");
    final userJsonData = json.decode(userPreferences!);

    final userToken = userJsonData["token"];

    // api request to get current user bookings
    BookingAPI bookingAPI = BookingAPI(token: userToken);
    _bookingModel = await bookingAPI.getBookingByUserId();

    if (_bookingModel.data != null) {
      // get bookings that have been paid for
      _bookingModel.data!.bookings = _bookingModel.data!.bookings!
          .where((element) =>
              element.bookingStatus != null &&
              element.bookingStatus != "CANCELLED")
          .toList();
    }

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
                image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill),
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
                            _bookingModel.message ??
                                'Could not get bookings data',
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w900,
                                fontSize: 20.0),
                          ))
                        ],
                      ));
                    } else {
                      return _bookingModel.data!.bookings!.length > 0
                          ? Expanded(
                              child: ListView.builder(
                                //physics: ,
                                //physics: AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: _bookingModel.data!.bookings!.length,
                                itemBuilder: (context, index) {
                                  return BookingsItem(
                                      bookingData:
                                          _bookingModel.data!.bookings![index]);
                                },
                              ),
                            )
                          : // no completed bookings
                          Expanded(
                              child: Column(children: [
                              SizedBox(height: 15),
                              Center(
                                  child: Text(
                                'No bookings yet',
                                style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w900,
                                    fontSize: 23.0),
                              )),
                              SizedBox(height: 7),
                              Center(
                                  child: Text(
                                'All your reserved bookings would appear here',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.0),
                              ))
                            ]));
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
  final Booking? bookingData;

  BookingsItem({Key? key, this.bookingData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int count = bookingData?.apartmentId?.apartmentImages?.length ?? 0;

    return Column(
      children: [
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: count > 0
                ? Image.network(
                    bookingData!.apartmentId!.apartmentImages!.first)
                : Text(
                    'No image',
                    style: TextStyle(
                        backgroundColor: Colors.white, fontFamily: 'Gilroy'),
                  ),
          ),
          contentPadding: EdgeInsets.all(0),
          title: Text(
            '${bookingData?.apartmentId?.apartmentName}',
            style: TextStyle(
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w900,
                fontSize: 23.0),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              "PAYMENT ${bookingData?.paymentStatus ?? ""}",
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
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
