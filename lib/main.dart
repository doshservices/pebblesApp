import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/provider/auth.dart';
import 'package:pebbles/screens/dashboard/adds_on/adds_on.dart';
import 'package:pebbles/screens/dashboard/apartment/book_apartment_preview.dart';
import 'package:pebbles/screens/dashboard/bookings/bookings_checkout.dart';
import 'package:pebbles/screens/dashboard/bookings/bookings_detail.dart';
import 'package:pebbles/screens/dashboard/carts.dart/carts_page.dart';
import 'package:pebbles/screens/dashboard/profile/settings.dart';

import 'package:pebbles/screens/splashscreen.dart';
import 'package:pebbles/screens/auth/walkthrough.dart';
import 'package:pebbles/screens/auth/register_page_one.dart';
import 'package:pebbles/screens/auth/register_host.dart';
import 'package:pebbles/screens/auth/register_host_email.dart';
import 'package:pebbles/screens/auth/otp_verification.dart';
import 'package:pebbles/screens/auth/continue_registration.dart';
import 'package:pebbles/screens/auth/complete_registration.dart';
import 'package:pebbles/screens/auth/login.dart';
import 'package:pebbles/screens/auth/reset_password.dart';
import 'package:pebbles/screens/auth/change_password.dart';
import 'package:pebbles/screens/auth/create_user_account.dart';
import 'package:pebbles/screens/dashboard/dashboard.dart';
import 'package:pebbles/screens/dashboard/profile/profile.dart';
import 'package:pebbles/screens/dashboard/bookings/bookings.dart';
import 'package:pebbles/screens/dashboard/wallet/wallet_history_detail.dart';
import 'package:pebbles/screens/dashboard/wallet/withdraw_funds.dart';
import 'package:pebbles/screens/dashboard/wallet/fund_wallet.dart';
import 'package:pebbles/screens/dashboard/wallet/voucher_amount.dart';
import 'package:pebbles/screens/dashboard/wallet/voucher_code.dart';
import 'package:pebbles/screens/dashboard/list_options/list_options.dart';
import 'package:pebbles/screens/dashboard/list_options/apartment_listing.dart';
import 'package:pebbles/screens/dashboard/list_options/event_listing.dart';
import 'package:pebbles/screens/dashboard/list_options/my_apartments.dart';
import 'package:pebbles/screens/dashboard/list_options/my_events.dart';
import 'package:pebbles/screens/dashboard/list_options/my_apartment_details.dart';
import 'package:pebbles/screens/dashboard/list_options/my_event_details.dart';
import 'package:pebbles/screens/dashboard/events/events.dart';
import 'package:pebbles/screens/dashboard/events/event_details.dart';
import 'package:pebbles/screens/dashboard/apartment/search.dart';
import 'package:pebbles/screens/dashboard/apartment/apartment_detail.dart';
import 'package:pebbles/screens/dashboard/apartment/book_apartment.dart';
import 'package:pebbles/screens/dashboard/holiday/holiday.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) {
          return GetMaterialApp(
            title: 'Pebbles Signatures',
            theme: ThemeData(
              primaryColor: kPrimaryColor,
              accentColor: kAccentColor,
              fontFamily: "Gilroy",
            ),
            home: auth.isAuth == true
                ? Dashboard(
                    0,
                  )
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapShot) =>
                        authResultSnapShot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : WalkThrough(),
                  ),
            routes: {
              kRegisterPageOne: (ctx) => RegisterPageOne(),
              kRegisterHost: (ctx) => RegisterHost(),
              kRegisterHostEmail: (ctx) => RegisterHostEmail(),
              kOtpVerification: (ctx) => OtpVerificationScreen(),
              kContinueRegistration: (ctx) => ContinueRegistration(),
              kCompleteRegistration: (ctx) => CompleteRegistration(),
              kCreateUserAccount: (ctx) => CreateUserAccount(),
              kLogin: (ctx) => LoginPage(),
              kResetPassword: (ctx) => ResetPassword(),
              kChangePassword: (ctx) => ChangePassword(),
              kDashboard: (ctx) => Dashboard(0),
              kProfile: (ctx) => Profile(),
              kBookings: (ctx) => Bookings(),
              kBookingsDetail: (ctx) => BookingsDetails(),
              kWalletHistoryDetail: (ctx) => WalletHistoryDetail(),
              kWithdrawFunds: (ctx) => WithdrawFunds(),
              kFundWallet: (ctx) => FundWallet(),
              kWalletVoucherAmount: (ctx) => WalletVoucherAmount(),
              kWalletVoucherCode: (ctx) => WalletVoucherCode(),
              kListOptions: (ctx) => ListOptions(),
              kApartmentListings: (ctx) => ApartmentListing(),
              kEventListings: (ctx) => EventListing(),
              kMyApartments: (ctx) => MyApartments(),
              kMyEvents: (ctx) => MyEvents(),
              kMyApartmentDetail: (ctx) => MyApartmentsDetails(),
              kMyEventDetails: (ctx) => MyEventsDetails(),
              kEvents: (ctx) => EventsPage(),
              kEventDetails: (ctx) => EventDetails(),
              kSearch: (ctx) => Search(),
              kApartmentDetail: (ctx) => ApartmentDetail(),
              KBookApartmentPreview: (ctx) => BookApartmentPreview(),
              kBookApartment: (ctx) => BookApartment(),
              KBookingsCheckout: (ctx) => BookingsCheckout(),
              KCartPage: (ctx) => CartsPage(),
              kHoliday: (ctx) => Holiday(),
              kAddsOn: (ctx) => AddsOn(),
              KSettings: (ctx) => Settings(),
            },
          );
        },
      ),
    );
  }
}
