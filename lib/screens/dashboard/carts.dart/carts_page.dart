import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/booking_model.dart';
import 'package:pebbles/provider/booking_api.dart';
import 'package:pebbles/screens/dashboard/dashboard.dart';
import 'package:pebbles/utils/shared/custom_default_button.dart';
import 'package:pebbles/utils/shared/error_snackbar.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';
import 'package:pebbles/utils/shared/top_back_navigation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartsPage extends StatefulWidget {
  @override
  State<CartsPage> createState() => _CartsPageState();
}

class _CartsPageState extends State<CartsPage> {
  BookingModel _bookingModel = BookingModel();
  String userToken = "";

  Future<BookingModel> getCartItems() async {
    final preferences = await SharedPreferences.getInstance();
    final userPreferences = preferences.getString("userData");
    final userJsonData = json.decode(userPreferences!);

    userToken = userJsonData["token"];

    // api request to get current user bookings
    BookingAPI bookingAPI = BookingAPI(token: userToken);
    _bookingModel = await bookingAPI.getBookingByUserId();

    // get bookings that have not been paid for
    if(_bookingModel.data != null){
      
      _bookingModel.data!.bookings = _bookingModel.data?.bookings!
          .where((element) =>
              element.bookingStatus != null && element.bookingStatus == "PENDING")
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
              FutureBuilder(
                future: getCartItems(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (_bookingModel.status == 'error') {
                      return Expanded(
                          child: Column(
                        children: [
                          Center(
                              child: Text(
                            _bookingModel.message ?? 'Could not get data',
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w900,
                                fontSize: 23.0),
                          ))
                        ],
                      ));
                    } else {
                      return _bookingModel.data!.bookings!.length > 0
                          ? Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: _bookingModel.data!.bookings!.length,
                                itemBuilder: (context, index) {
                                  return CartItem(
                                      token: userToken,
                                      bookingData:
                                          _bookingModel.data!.bookings![index]);
                                },
                              ),
                            )
                          : Expanded(
                              child: Column(children: [
                              SizedBox(height: 15),
                              Center(
                                  child: Text(
                                'No item in cart',
                                style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w900,
                                    fontSize: 23.0),
                              )),
                              SizedBox(height: 7),
                              Center(
                                  child: CustomDefaultButton(
                                text: 'Find apartments',
                                onPressed: () {
                                  // navigate to dashboard
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: ((context) => Dashboard(0))),
                                      (Route<dynamic> route) => false);
                                },
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

class CartItem extends StatefulWidget {
  final Booking? bookingData;
  final token;

  CartItem({Key? key, this.bookingData, this.token}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  final formatCurrency = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    int count = widget.bookingData?.apartmentId?.apartmentImages?.length ?? 0;

    return Column(
      children: [
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: count > 0
                ? Image.network(
                    widget.bookingData!.apartmentId!.apartmentImages!.first)
                : Text(
                    'No image',
                    style: TextStyle(
                        backgroundColor: Colors.white, fontFamily: 'Gilroy'),
                  ),
          ),
          contentPadding: EdgeInsets.all(0),
          title: Text('${widget.bookingData?.apartmentId?.apartmentName}',
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w900,
                  fontSize: 23.0)),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
                "N${formatCurrency.format(widget.bookingData?.bookingAmount ?? 0)}",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Gilroy',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold)),
          ),
          trailing: InkWell(
            onTap: () {
              // navigate to payment
              Navigator.of(context)
                  .pushNamed(KBookingsCheckout, arguments: widget.bookingData);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child:
                  Icon(Icons.arrow_forward_ios, color: Colors.black, size: 27),
            ),
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(kBookingsDetail, arguments: widget.bookingData);
          },
        ),
        Divider()
      ],
    );
  }
}
