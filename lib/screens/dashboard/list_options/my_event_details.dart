import 'package:flutter/material.dart';

class MyEventsDetails extends StatelessWidget {
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
                            image: AssetImage("assets/images/event2.png"),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Comedy night stand",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "30/01/2020",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
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
                  "Side attractions",
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
                        child: Image.asset("assets/images/event.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset("assets/images/event.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset("assets/images/event.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset("assets/images/event.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset("assets/images/event.png"),
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
