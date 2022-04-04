import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pebbles/bloc/services.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/utils/shared/custom_default_button.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';

class AdminWalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill),
            color: Colors.grey.withOpacity(0.2)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/wallet_bg.png",
                      ),
                    ),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Available Balance",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: 'Gilroy'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    "N200,000",
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Image.asset("assets/images/Cards.png")
                          ],
                        ),
                      ),
                      Text(
                        "Withdrawable Balance",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Gilroy',
                            fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          "N200,000",
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 0.0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  child: CustomDefaultButton(
                    text: "Buy Voucher",
                    onPressed: () {
                      Navigator.of(context).pushNamed(kWalletVoucherAmount);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 0.0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  child: CustomDefaultButton(
                    text: "Fund Wallet",
                    isPrimaryButton: false,
                    borderColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).pushNamed(kFundWallet);
                    },
                  ),
                ),
              ),
              Card(
                elevation: 0.0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  child: CustomDefaultButton(
                    text: "Withdraw",
                    isPrimaryButton: false,
                    borderColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).pushNamed(kWithdrawFunds);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "History",
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AdminWalletItem(),
                    AdminWalletItem(),
                    AdminWalletItem(),
                    AdminWalletItem(),
                    AdminWalletItem(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminWalletItem extends StatelessWidget {
  const AdminWalletItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          // leading: Image.asset(
          //   "assets/images/hotel.png",
          //   width: 40,
          // ),
          contentPadding: EdgeInsets.all(0),
          title: Row(
            children: [
              Text(
                "Cubana",
                style: TextStyle(fontFamily: 'Gilroy'),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "N30,000",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          subtitle: Text("10:46 AM  20 November, 2020"),
          trailing: Image.asset(
            "assets/images/arrowforward.png",
            width: 40,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(kWalletHistoryDetail);
          },
        ),
        Divider()
      ],
    );
  }
}
