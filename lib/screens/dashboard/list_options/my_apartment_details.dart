import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/utils/shared/custom_textformfield.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';

class MyApartmentsDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
            ),
            color: Colors.grey.withOpacity(0.2)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/hotel2.png"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                  ),
                  Positioned(
                    left: 20,
                    top: 60,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                size: 16,
                              ),
                              Text("Back"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: 20,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Theme.of(context).primaryColor,
                            ),
                            Text(
                              "Use Map",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cubana Victoria Island",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text("17 Adeola Odeku Street, Victoria Island, Lagos."),
                      Divider(),
                      Text(
                          "Cupidatat reprehenderit nulla ex elit dolor dolore minim in aute tempor. Ipsum excepteur id voluptate elit nulla ipsum t.")
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Facilities",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset("assets/images/hotel.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset("assets/images/hotel.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset("assets/images/hotel.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset("assets/images/hotel.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset("assets/images/hotel.png"),
                      )
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

class MyApartmentListtile extends StatelessWidget {
  const MyApartmentListtile({
    Key? key,
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
                Text(""),
                Text("Delete",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
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
