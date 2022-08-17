import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
            ),
            color: Colors.grey.withOpacity(0.2)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/images/wallet_bg.png",
                    ),
                  ),
                ),
                height: 120,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Wallet Balance",
                          style: TextStyle(color: Colors.white),
                        ),
                        Image.asset("assets/images/Cards.png")
                      ],
                    ),
                    Text(
                      "N200,000",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: RoundedRaisedButton(
                    label: "Buy Voucher",
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
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: RoundedRaisedButton(
                    label: "Fund Wallet",
                    buttonColor: Colors.white,
                    labelColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).pushNamed(kFundWallet);
                    },
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: RoundedRaisedButton(
                    label: "Withdraw",
                    buttonColor: Colors.white,
                    labelColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).pushNamed(kWithdrawFunds);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "History",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
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
      ),
    );
  }
}

class WalletItem extends StatelessWidget {
  const WalletItem({
    Key key,
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
              Text("Cubana"),
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
