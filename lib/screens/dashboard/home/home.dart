import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/bg.png",
            ),
          ),
          color: Colors.grey.withOpacity(0.2),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Card(
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20, top: 15),
                    border: InputBorder.none,
                    hintText: "Where do you have in mind?",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            "assets/images/search_icon.png",
                            width: 20,
                            height: 20,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "assets/images/home_image1.png",
                            ),
                          )),
                      child: Text("")),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        "We have the best apartments",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GridView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(kSearch);
                    },
                    child: HomeWidget(
                      title: "Apartment",
                      icon: "assets/images/home_icon.png",
                      color: Color(0xff21A58F).withOpacity(0.1),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(kAddsOn);
                    },
                    child: HomeWidget(
                      title: "Laundry",
                      icon: "assets/images/laundry_icon.png",
                      color: Color(0xffFB5448).withOpacity(0.1),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(kEvents);
                    },
                    child: HomeWidget(
                      title: "Events",
                      icon: "assets/images/event_icon.png",
                      color: Color(0xff6A83E5).withOpacity(0.1),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(kHoliday);
                    },
                    child: HomeWidget(
                      title: "Holiday",
                      icon: "assets/images/holiday_icon.png",
                      color: Color(0xff2AF608).withOpacity(0.1),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(kAddsOn);
                    },
                    child: HomeWidget(
                      title: "Food",
                      icon: "assets/images/food_icon.png",
                      color: Color(0xffC619AA).withOpacity(0.1),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(kAddsOn);
                    },
                    child: HomeWidget(
                      title: "Ride",
                      icon: "assets/images/ride_icon.png",
                      color: Color(0xffE9360F).withOpacity(0.1),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Stack(
                children: [
                  Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "assets/images/home_image2.png",
                            ),
                          )),
                      child: Text("")),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        "Explore beautiful places in your city",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Text("Apartments Near you",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).primaryColor)),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ApartmentItem(),
                    ApartmentItem(),
                    ApartmentItem(),
                    ApartmentItem(),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("See more",
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).accentColor)),
                ],
              ),
              SizedBox(height: 20),
              Stack(
                children: [
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            "assets/images/home_image3.png",
                          ),
                        )),
                    child: Text(""),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        "Book an appartment and you also get access to great meals",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ApartmentItem extends StatelessWidget {
  const ApartmentItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.hardEdge,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/hotel2.png",
              width: 150,
              height: 130,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "Cubana ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text("Victoria Island, Lagos."),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 5, bottom: 5),
              child: Text(
                "N25,000 /night",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  String? icon, title;
  Color? color;
  HomeWidget({this.color, this.icon, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: color,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            height: 60,
            width: 60,
            child: Center(
              child: Image.asset(
                "$icon",
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Text(
          "$title",
          style: TextStyle(fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
