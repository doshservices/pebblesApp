import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pebbles/bloc/services.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/apartment_model.dart';
import 'package:pebbles/model/booking_model.dart';
import 'package:pebbles/provider/apartment_api.dart';
import 'package:pebbles/provider/booking_api.dart';
import 'package:pebbles/screens/dashboard/dashboard.dart';
import 'package:pebbles/utils/shared/custom_default_button.dart';
import 'package:pebbles/utils/shared/error_snackbar.dart';
import 'package:pebbles/utils/shared/top_back_navigation_widget.dart';

class BookingsDetails extends StatefulWidget {
  @override
  _BookingsDetailsState createState() => _BookingsDetailsState();
}

class _BookingsDetailsState extends State<BookingsDetails> {
  Booking bookingData = Booking();
  bool _isLoading = false;

  Future<void> getApartmentDetails() async {
    String userToken = await Services.getUserToken();

    // api request to get apartment details
    setState(() {
      _isLoading = true;
    });

    try {
      ApartmentAPI apartmentAPI = ApartmentAPI(token: userToken);
      ApartmentModel apartmentModel = await apartmentAPI
          .getApartmentById(bookingData.apartmentId?.sId ?? "");

      if (apartmentModel.status != 'error') {
        Navigator.of(context).pushNamed(kApartmentDetail,
            arguments: {'apartment': apartmentModel.data!.apartment});
      } else {
        ErrorSnackBar.displaySnackBar(
            'Error', apartmentModel.message ?? 'Could not get apartment data');
      }
    } catch (e) {
      ErrorSnackBar.displaySnackBar('Error', 'Could not get apartment data');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bookingData = ModalRoute.of(context)!.settings.arguments as Booking;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill),
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
                  "${bookingData.apartmentId?.apartmentName ?? ""} booking details",
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              BookingsDetailItem(bookingData: bookingData),
              Container(
                width: MediaQuery.of(context).size.width,
                child: CustomDefaultButton(
                  text: "Make payment",
                  onPressed: () {
                    // navigate to payment
                    Navigator.of(context)
                        .pushNamed(KBookingsCheckout, arguments: bookingData);
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                child: CustomDefaultButton(
                    text: "View apartment details",
                    onPressed: getApartmentDetails,
                    isLoading: _isLoading,
                    isPrimaryButton: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingsDetailItem extends StatefulWidget {
  Booking bookingData = Booking();

  BookingsDetailItem({Key? key, required this.bookingData}) : super(key: key);

  @override
  State<BookingsDetailItem> createState() => _BookingsDetailItemState();
}

class _BookingsDetailItemState extends State<BookingsDetailItem> {
  String? checkinDateFormat;

  String? checkoutDateFormat;

  BookingModel _bookingModel = BookingModel();

  Future<void> removeItemFromCart(String bookingId) async {
    final userToken = await Services.getUserToken();

    BookingAPI bookingAPI = BookingAPI(token: userToken);
    _bookingModel = await bookingAPI.cancelBooking(bookingId);

    if (_bookingModel.status == "error") {
      ErrorSnackBar.displaySnackBar(
          "Error", _bookingModel.message ?? "Something went wrong");
    } else {
      // deleted
      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('Success',
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.bold,
                      fontSize: 17)),
              content: Text('Deleted successfully',
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.bold,
                      fontSize: 17)),
              actions: <Widget>[
                CupertinoDialogAction(
                    child: Text('Okay',
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.bold,
                            fontSize: 17)),
                    onPressed: () {
                      Navigator.pop(context);
                      // navigate back to cart screen
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: ((context) => Dashboard(2))),
                          (Route<dynamic> route) => false);
                    }),
              ],
            );
          });
    }
  }

  void cancelBookingOption() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Delete',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.bold,
                    fontSize: 17)),
            content: Text('Do you want to remove this item from your cart?',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.bold,
                    fontSize: 17)),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.bold,
                          fontSize: 17))),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  // display loader

                  await removeItemFromCart(widget.bookingData.sId ?? "");
                },
                child: Text(
                  'Yes!',
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.red),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    DateTime checkInDate = DateTime.parse(widget.bookingData.checkInDate!);
    DateTime checkOutDate = DateTime.parse(widget.bookingData.checkOutDate!);

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
              contentPadding: EdgeInsets.all(0),
              title: Text(
                "Check-in date",
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800),
              ),
              trailing: Text(
                checkinDateFormat!,
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                "Check-out date",
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800),
              ),
              trailing: Text(
                checkoutDateFormat!,
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                "Adds-on",
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800),
              ),
              trailing: Image.asset(
                "assets/images/accept.png",
                width: 40,
              ),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                "No. of guest",
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800),
              ),
              trailing: Text(
                '${widget.bookingData.numberOfGuests}',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                "Payment status",
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800),
              ),
              trailing: Text(
                '${widget.bookingData.paymentStatus}',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                "Amount",
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800),
              ),
              trailing: Text(
                'N${widget.bookingData.bookingAmount}',
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Divider(),
            ListTile(
              onTap: cancelBookingOption,
              contentPadding: EdgeInsets.all(0),
              title: Text(
                "Cancel",
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 18.0,
                    color: Colors.red,
                    fontWeight: FontWeight.w800),
              ),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: IconButton(
                  onPressed: cancelBookingOption,
                  icon: Icon(Icons.delete_forever_rounded,
                      color: Colors.red, size: 27),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
