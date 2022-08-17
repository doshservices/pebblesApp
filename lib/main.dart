import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/screens/dashboard/adds_on/adds_on.dart';
import 'package:pebbles/screens/dashboard/bookings/bookings_detail.dart';

import 'package:pebbles/screens/auth/register_page_one.dart';
import 'package:pebbles/screens/auth/register_page_two.dart';
import 'package:pebbles/screens/auth/register_page_three.dart';
import 'package:pebbles/screens/auth/opt_verification.dart';
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
import 'package:pebbles/screens/dashboard/search/search.dart';
import 'package:pebbles/screens/dashboard/search/apartment_detail.dart';
import 'package:pebbles/screens/dashboard/holiday/holiday.dart';

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
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pebbles Signatures',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kAccentColor),
      ),
      home: RegisterPageOne(),
      routes: {
        kRegisterPageOne: (ctx) => RegisterPageOne(),
        kRegisterPageTwo: (ctx) => RegisterPageTwo(),
        kRegisterPageThree: (ctx) => RegisterPageThree(),
        kOtpVerification: (ctx) => OtpVerification(),
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
        kHoliday: (ctx) => Holiday(),
        kAddsOn: (ctx) => AddsOn(),
      },
    );
  }
}
