// select payment option
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/booking_model.dart';
import 'package:pebbles/model/booking_status.dart';
import 'package:pebbles/provider/booking_api.dart';
import 'package:pebbles/screens/dashboard/dashboard.dart';
import 'package:pebbles/utils/shared/custom_default_button.dart';
import 'package:pebbles/utils/shared/error_snackbar.dart';
import 'package:pebbles/utils/shared/top_back_navigation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookApartmentPreview extends StatefulWidget {
  const BookApartmentPreview({Key? key}) : super(key: key);

  @override
  State<BookApartmentPreview> createState() => _BookApartmentPreviewState();
}

class _BookApartmentPreviewState extends State<BookApartmentPreview> {
  BookingStatus _bookingStatus = BookingStatus();
  Booking apartmentBooking = Booking();
  bool _isLoading = false;

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final preferences = await SharedPreferences.getInstance();
      final userPreferences = preferences.getString("userData");
      final userJsonData = json.decode(userPreferences!);

      final userToken = userJsonData["token"];
      final _currentAddress = userJsonData["currentAddress"];

      // create booking
      BookingAPI bookingAPI = BookingAPI(token: userToken);
      _bookingStatus = await bookingAPI.createBooking(apartmentBooking);

      if (_bookingStatus.status != 'error') {
        // success, display "added to cart icon" and option to go to cart or continue shopping

        showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            isDismissible: false,
            context: context,
            builder: (ctx) {
              return FractionallySizedBox(
                heightFactor: 0.7,
                child: Container(
                  //margin: EdgeInsets.only(top: 40),
                  padding: EdgeInsets.only(bottom: 30.0, top: 30.0),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                  ),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.0),
                      child: Image(
                        image: AssetImage("assets/images/verified.png"),
                        height: MediaQuery.of(context).size.height / 10,
                        fit: BoxFit.contain,
                      ),
                    ),
                    // app name
                    Text(
                      "Apartment Booked",
                      style: TextStyle(
                          color: Color(0xFF4368B2),
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                          fontFamily: 'Gilroy'),
                    ),
                    // Text desc
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Added to cart. Make payment within 24hrs for your booked apartments",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Gilroy'),
                      ),
                    ),
                    SizedBox(height: 30),
                    // button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: CustomDefaultButton(
                        onPressed: () {
                          // Navigate to homePage and remove previously stacked screen
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: ((context) => Dashboard(2))),
                              (Route<dynamic> route) => false);
                        },
                        text: 'Pay now',
                      ),
                    ),
                    SizedBox(height: 7),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: CustomDefaultButton(
                        isPrimaryButton: false,
                        onPressed: () {
                          // Navigate to homePage and remove previously stacked screen
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              kDashboard, (Route<dynamic> route) => false);
                        },
                        text: 'Find more apartments',
                      ),
                    ),
                  ]),
                ),
              );
            });
      } else {
        ErrorSnackBar.displaySnackBar(
            'Error', _bookingStatus.message ?? "Something went wrong");
      }
    } catch (e) {
      ErrorSnackBar.displaySnackBar('Error', "${e.toString()}");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat("#,##0.00", "en_US");

    Map data = ModalRoute.of(context)?.settings.arguments as Map;
    apartmentBooking = data["apartmentBooking"];

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill),
            color: Colors.grey.withOpacity(0.2)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBackNavigationWidget(),
              Text(
                "Detail preview",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Gilroy'),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 70,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Check-in date',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        apartmentBooking.checkInDate ?? "",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Gilroy',
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Divider(
                    thickness: 2,
                    color: Colors.black54,
                  )
                ],
              ),
              SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Check-out date',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        apartmentBooking.checkOutDate ?? "",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Gilroy',
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Divider(
                    thickness: 2,
                    color: Colors.black54,
                  )
                ],
              ),
              SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'No. of guest',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        apartmentBooking.numberOfGuests.toString(),
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Gilroy',
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Divider(
                    thickness: 2,
                    color: Colors.black54,
                  )
                ],
              ),
              SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'N${formatCurrency.format(apartmentBooking.bookingAmount)}',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Gilroy',
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Divider(
                    thickness: 2,
                    color: Colors.black54,
                  )
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: CustomDefaultButton(
                  text: "Book",
                  isLoading: _isLoading,
                  onPressed: () async {
                    // create booking
                    await _submit();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
