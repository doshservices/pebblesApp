import 'package:flutter/material.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';
import 'package:pebbles/utils/shared/top_back_navigation_widget.dart';

class WalletHistoryDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill),
            color: Colors.grey.withOpacity(0.2)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBackNavigationWidget(),
              SizedBox(height: 10),
              Container(
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
                                "Wallet Balance",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: 'Gilroy'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  "N200,000",
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    color: Colors.white,
                                    fontSize: 24,
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
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Cubana",
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text("20 November, 2020", style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 10,
              ),
              Text("10:46 AM", style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 25,
              ),
              Text("Lola rae",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Cubana apartment",
                                style: TextStyle(fontSize: 16)),
                            Text("N160,00.00", style: TextStyle(fontSize: 16))
                          ],
                        ),
                      ),
                      Divider(thickness: 1.2),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Cubana apartment",
                                style: TextStyle(fontSize: 16)),
                            Text("N160,00.00", style: TextStyle(fontSize: 16))
                          ],
                        ),
                      ),
                      Divider(thickness: 1.2),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Cubana apartment",
                                style: TextStyle(fontSize: 16)),
                            Text("N160,00.00", style: TextStyle(fontSize: 16))
                          ],
                        ),
                      ),
                      Divider(thickness: 1.2),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "N200,00.00",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
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
            // Navigator.of(context).pushNamed(kBookingsDetail);
          },
        ),
        Divider()
      ],
    );
  }
}
