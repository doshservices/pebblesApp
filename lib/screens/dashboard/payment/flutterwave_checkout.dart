import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:pebbles/bloc/services.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/provider/booking_api.dart';
import 'package:pebbles/utils/shared/bottom_sheets.dart';
import 'package:pebbles/utils/shared/dialog_widgets.dart';
import 'package:pebbles/utils/shared/error_snackbar.dart';
import 'package:pebbles/utils/shared/top_back_navigation_widget.dart';

class FlutterwaveCheckout extends StatefulWidget {
  const FlutterwaveCheckout({Key? key}) : super(key: key);

  @override
  State<FlutterwaveCheckout> createState() => _FlutterwaveCheckoutState();
}

class _FlutterwaveCheckoutState extends State<FlutterwaveCheckout> {
  final DialogWidgets dialogWidgets = DialogWidgets();

  // verify payment
  Future verifyPayment(String transactionReference) async {
    dialogWidgets.showCenterLoadingDialog(title: "Verifying");

    try {
      final userToken = await Services.getUserToken();

      BookingAPI bookingAPI = BookingAPI(token: userToken);

      String paymentURL = await bookingAPI
          .verifyBookingPaymentWithFlutterwave(transactionReference);

      // dismiss dialog
      Get.back();
      Get.offAllNamed(KCartPage);
    } catch (e) {
      // dismiss dialog
      Get.back();
      ErrorSnackBar.displaySnackBar('Error', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    String paymentURL = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bg.png"),
                    fit: BoxFit.fill),
                color: Colors.grey.withOpacity(0.2)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: TopBackNavigationWidget(),
                ),
                Expanded(
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(
                        url: Uri.parse("$paymentURL")), // your website url
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        javaScriptEnabled: true,
                        javaScriptCanOpenWindowsAutomatically: true,
                      ),
                    ),
                    onLoadStart:
                        (InAppWebViewController controller, Uri? url) async {
                      print(url);
                      final queryParams = url?.queryParameters;

                      if (queryParams != null && queryParams.isNotEmpty) {
                        String? status = queryParams["status"];
                        String? transactionReference = queryParams["tx_ref"];

                        // verify payment reference
                        if (status != null &&
                            transactionReference != null &&
                            status.toLowerCase() == "successful") {
                          //await verifyPayment(transactionReference);
                          BottomSheets.modalBottomSheet(
                              context: context,
                              title: 'Successful',
                              subtitle: 'Your payment is successful',
                              onPressed: () {
                                Get.close(3);
                              });
                        }
                      }

                      // handle webhook query for transaction status
                      // query:"status=cancelled&tx_ref=PS_74961520"
                      // status=successful&tx_ref=PS_40204505&transaction_id=3290856
                    },
                    onLoadStop: (InAppWebViewController controller, Uri? url) {
                      print(url!.path);
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
