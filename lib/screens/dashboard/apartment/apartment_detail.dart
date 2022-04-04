import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:pebbles/constants.dart';
import 'package:pebbles/model/apartment_model.dart';
import 'package:pebbles/utils/shared/custom_default_button.dart';
import 'package:pebbles/utils/shared/top_back_navigation_widget.dart';

// ignore: must_be_immutable
class ApartmentDetail extends StatelessWidget {
  Apartment apartment = new Apartment();
  final formatCurrency = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)?.settings.arguments as Map;
    apartment = data['apartment'];

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill),
            color: Colors.grey.withOpacity(0.2)),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Stack(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 300.0,
                              viewportFraction: 1,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                            ),
                            items: apartment.apartmentImages!.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(i),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20))),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          Positioned(
                            left: 20,
                            top: 25,
                            child: Row(
                              children: [
                                TopBackNavigationWidget(),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 20,
                            bottom: 20,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
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
                                        fontFamily: 'Gilroy',
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      apartment.apartmentName ?? "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Gilroy',
                                          fontSize: 22.0),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "${apartment.apartmentState}, ${apartment.apartmentCountry}",
                                      style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: 18,
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                RichText(
                                    text: TextSpan(
                                        text: '₦',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins',
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 18.0),
                                        children: [
                                      TextSpan(
                                          text:
                                              '${formatCurrency.format(apartment.price)}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Gilroy',
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 18.0)),
                                    ])),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Type of apartment: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Gilroy',
                                      fontSize: 18.0),
                                ),
                                Text(
                                  "${apartment.typeOfApartment}",
                                  style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 18,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Number of rooms: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Gilroy',
                                      fontSize: 18.0),
                                ),
                                Text(
                                  "${apartment.numberOfRooms}",
                                  style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 18,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Divider(),
                            Text(
                              apartment.apartmentInfo ?? "",
                              style: TextStyle(
                                  fontFamily: 'Gilroy', fontSize: 17.0),
                            )
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Facilities",
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        children: apartment.facilities!
                            .map((element) => FacilityWidget(facility: element))
                            .toList(),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0))),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Column(
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: '₦',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                  children: [
                                TextSpan(
                                  text:
                                      '${formatCurrency.format(apartment.price)}',
                                  style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                )
                              ])),
                          Text("per night",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                  fontFamily: 'Gilroy',
                                  fontSize: 16.0)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CustomDefaultButton(
                    text: "Book",
                    onPressed: () {
                      Navigator.of(context).pushNamed(kBookApartment,
                          arguments: {'apartment': apartment});
                    },
                  ),
                ],
              ),
            )
          ],
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

class FacilityWidget extends StatelessWidget {
  final String facility;

  FacilityWidget({Key? key, required this.facility}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          facility,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Gilroy',
            fontSize: 16.0,
            background: Paint()
              ..color = Colors.white
              ..strokeWidth = 17
              ..style = PaintingStyle.stroke,
          ),
        ),
      ),
    );
  }
}
