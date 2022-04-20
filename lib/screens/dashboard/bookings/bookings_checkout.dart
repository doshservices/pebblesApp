import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pebbles/bloc/services.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/booking_model.dart';
import 'package:pebbles/provider/booking_api.dart';
import 'package:pebbles/utils/shared/custom_default_button.dart';
import 'package:pebbles/utils/shared/dialog_widgets.dart';
import 'package:pebbles/utils/shared/error_snackbar.dart';
import 'package:pebbles/utils/shared/top_back_navigation_widget.dart';

class BookingsCheckout extends StatelessWidget {
  
  BookingsCheckout({Key? key}) : super(key: key);
  
  Booking _booking = Booking();
  DialogWidgets dialogWidgets = DialogWidgets();

  Future<void> payWithFlutterwave() async {
    dialogWidgets.showCenterLoadingDialog();

    try {
      final userToken = await Services.getUserToken();

      BookingAPI bookingAPI = BookingAPI(token: userToken);

      String paymentURL =
          await bookingAPI.payForBookingWithFlutterwave(_booking.sId!);

      // dismiss dialog
      Get.back();
      Get.toNamed(KFlutterwaveCheckout, arguments: paymentURL);
      
    } catch (e) {
      // dismiss dialog
      Get.back();
      ErrorSnackBar.displaySnackBar('Error', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    _booking = ModalRoute.of(context)!.settings.arguments as Booking;

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
                  "Select payment method:",
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                  'Pay for booking ${_booking.apartmentId?.apartmentName ?? ""}',
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700])),
              SizedBox(
                height: 80,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: CustomDefaultButton(
                        text: "Pay with wallet",
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: CustomDefaultButton(
                          text: "Pay with flutterwave",
                          onPressed: () {
                            payWithFlutterwave();
                          },
                          isPrimaryButton: false),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: CustomDefaultButton(
                          text: "Pay with bank transfer",
                          onPressed: () {},
                          isPrimaryButton: false),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
