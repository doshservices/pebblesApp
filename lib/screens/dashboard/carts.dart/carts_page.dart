import 'package:flutter/material.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';

class CartsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
            ),
            color: Colors.grey.withOpacity(0.2)),
        child: Column(
          children: [
            // SizedBox(
            //   height: 40,
            // ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CartItem(),
                    CartItem(),
                    CartItem(),
                    CartItem(),
                    CartItem(),
                    CartItem(),
                    CartItem(),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: RoundedRaisedButton(
                label: "Proceed",
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Image.asset(
            "assets/images/hotel.png",
            width: 40,
          ),
          contentPadding: EdgeInsets.all(0),
          title: Text("Cubana Victoria Island"),
          subtitle: Text("Victoria Island, Lagos."),
          trailing: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      size: 14,
                      color: Colors.pink,
                    ),
                    Icon(
                      Icons.star,
                      size: 14,
                      color: Colors.pink,
                    ),
                    Icon(
                      Icons.star,
                      size: 14,
                      color: Colors.pink,
                    ),
                    Icon(
                      Icons.star,
                      size: 14,
                      color: Colors.pink,
                    ),
                  ],
                ),
                Text("N30,000",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold)),
              ],
            ),
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
