import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pebbles/bloc/services.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/wallet_model.dart';
import 'package:pebbles/provider/wallet_api.dart';
import 'package:pebbles/utils/shared/custom_default_button.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';

class WalletPage extends StatefulWidget {
  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  WalletModel _walletModel = WalletModel();

  Future<WalletModel> getCartItems() async {
    String userToken = await Services.getUserToken();

    // api request to get current user wallet
    WalletAPI walletAPI = WalletAPI(token: userToken);
    _walletModel = await walletAPI.getUserWallet();

    return _walletModel;
  }

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
                            FutureBuilder(
                                future: getCartItems(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (_walletModel.status == 'error') {
                                      return Center(
                                          child: Text('Could not get data',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Gilroy',
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 20.0)));
                                    } else {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Wallet Balance",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontFamily: 'Gilroy'),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.0),
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: '₦',
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontFamily:
                                                              'Poppins'),
                                                      children: [
                                                    TextSpan(
                                                      text:
                                                          '${_walletModel.data?.wallet?.availableBalance ?? 0}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ]))),
                                        ],
                                      );
                                    }
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white),
                                      ),
                                    );
                                  }
                                  return Column();
                                }),
                            Image.asset("assets/images/Cards.png")
                          ],
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
                    WalletItem(),
                    WalletItem(),
                    WalletItem(),
                    WalletItem(),
                    WalletItem(),
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

class WalletItem extends StatelessWidget {
  const WalletItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
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
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Gilroy'),
              ),
            ],
          ),
          subtitle: Text(
            "10:46 AM  20 November, 2020",
            style: TextStyle(fontFamily: 'Gilroy'),
          ),
          trailing: Image.asset(
            "assets/images/arrowforward.png",
            width: 40,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(kWalletHistoryDetail);
          },
        ),
        Divider(
          thickness: 1.5,
        )
      ],
    );
  }
}
