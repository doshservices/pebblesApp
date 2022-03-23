import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:pebbles/bloc/apartmentBloc.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/apartment_model.dart';
import 'package:pebbles/utils/shared/error_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position? _currentPosition;
  String? _currentAddress;
  late ApartmentModel _apartmentModel = ApartmentModel();
  ApartmentBloc apartmentBloc = ApartmentBloc();

  String location = "";

  // get current user location
  Future _getCurrentLocation() async {
    // check location permission
    LocationPermission checkPermission = await Geolocator.checkPermission();

    if (checkPermission == LocationPermission.denied ||
        checkPermission == LocationPermission.deniedForever) {
      // location denied, open app location settings
      // TODO: prompt user to open location to grant permission
      //await Geolocator.openAppSettings();

      LocationPermission permission = await Geolocator.requestPermission();
    } else if (checkPermission == LocationPermission.always ||
        checkPermission == LocationPermission.whileInUse) {
      // location permission granted
      Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best,
              forceAndroidLocationManager: true)
          .then((Position position) {
        setState(() {
          _currentPosition = position;
          _getAdressFromLatLng();
        });
      }).catchError((e) {
        print(e);
      });
    } else {
      // request permission
      LocationPermission permission = await Geolocator.requestPermission();
    }
  }

  /// convert longitude and latitude values with geocoding: internet connection needed
  Future _getAdressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        print("${place.locality}, ${place.postalCode}, ${place.country}");
        _currentAddress = place.locality;
      });

      // set currentAddress to preference
      final preferences = await SharedPreferences.getInstance();
      final userPreferences = preferences.getString("userData");
      final userJsonData = json.decode(userPreferences!);

      userJsonData["currentAddress"] = _currentAddress;
      final userData = json.encode(userJsonData);

      preferences.setString("userData", userData);
    } catch (e) {
      // display network error, unable to get coordinfates
      ErrorSnackBar.displaySnackBar("Error", "${e.toString()}");
    }
  }

  @override
  void initState() {
    super.initState();

    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.fill,
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
                color: Color(0xFFE3E8E9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey, width: 1)),
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    if (value.isNotEmpty) {
                      Navigator.of(context)
                          .pushNamed(kSearch, arguments: {'location': value});
                    }
                  },
                  onChanged: (value) {
                    location = value;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20, top: 15),
                    border: InputBorder.none,
                    hintText: "Where do you have in mind?",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Gilroy',
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // search using search icon
                            if (location.isNotEmpty) {
                              Navigator.of(context).pushNamed(kSearch,
                                  arguments: {'location': location});
                            }
                          },
                          child: Container(
                            width: 20,
                            height: 20,
                            child: Image.asset(
                              "assets/images/search_blue.png",
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
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
                          borderRadius: BorderRadius.circular(8),
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
                      borderRadius: BorderRadius.circular(8),
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
                            fontFamily: 'Gilroy',
                            fontSize: 22),
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
                      Navigator.of(context).pushNamed(kSearch,
                          arguments: {'location': _currentAddress ?? "Lagos"});
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
                          borderRadius: BorderRadius.circular(8),
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
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Explore beautiful places in your city",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy',
                              fontSize: 22),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 35),
              Text("Apartments Near you",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Gilroy',
                      color: Theme.of(context).primaryColor)),
              SizedBox(height: 7),
              FutureBuilder(
                  future: apartmentBloc
                      .getApartmentsByUserLocation(_currentAddress ?? "Lagos"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      _apartmentModel = snapshot.data as ApartmentModel;

                      if (_apartmentModel.status == "error") {
                        return Column(
                          children: [
                            Center(
                                child: Text(
                              'Could not get apartments, make sure you are connected to the internet',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16.0),
                            ))
                          ],
                        );
                      } else {
                        int apartmentLength =
                            _apartmentModel.data?.apartments?.length ?? 0;
                        double height =
                            MediaQuery.of(context).size.height / 2.6;

                        if (apartmentLength <= 0) {
                          height = 0;
                        }

                        return Row(
                          children: [
                            Expanded(
                                child: SizedBox(
                              height: height,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: _apartmentModel.data?.apartments
                                        ?.take(20)
                                        .length ??
                                    0,
                                itemBuilder: (context, index) {
                                  return ApartmentItem(
                                      apartment: _apartmentModel
                                          .data!.apartments![index]);
                                },
                              ),
                            ))
                          ],
                        );
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Column(
                        children: [LinearProgressIndicator()],
                      );
                    }

                    return Container();
                  }),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(kSearch,
                          arguments: {'location': _currentAddress ?? "Lagos"});
                    },
                    child: Text("See more",
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 16,
                            color: Theme.of(context).accentColor)),
                  ),
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
                        borderRadius: BorderRadius.circular(8),
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
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Book an appartment and you also get access to great meals",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                            fontSize: 22,
                          ),
                        ),
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
  final Apartment? apartment;
  final formatCurrency = new NumberFormat("#,##0.00", "en_US");

  ApartmentItem({Key? key, this.apartment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int count = apartment!.apartmentImages!.length;

    if (apartment != null) {
      if (apartment!.apartmentImages != null) {
        print("not null");
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(kApartmentDetail, arguments: {'apartment': apartment});
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.hardEdge,
        child: Container(
          width: MediaQuery.of(context).size.width / 2.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              count > 0
                  ? Image.network(
                      apartment!.apartmentImages!.first,
                      width: MediaQuery.of(context).size.width / 2.6,
                      height: MediaQuery.of(context).size.height / 5,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width / 2.6,
                      height: MediaQuery.of(context).size.height / 5,
                      child: Center(
                        child: Text("No Image",
                            style: TextStyle(fontFamily: 'Gilroy')),
                      )),
              Padding(
                padding: EdgeInsets.fromLTRB(7, 4, 2, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        apartment?.apartmentName ?? "",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                            fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        '${apartment?.address}, ${apartment?.apartmentState}, ${apartment?.apartmentCountry}',
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5.0, top: 5, bottom: 5),
                      child: Text(
                        "N${formatCurrency.format(apartment?.price)} /night",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy'),
                      ),
                    )
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
            height: 65,
            width: 65,
            child: Center(
              child: Image.asset(
                "$icon",
                width: 35,
                height: 35,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Text(
          "$title",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontFamily: 'Gilroy', fontSize: 16),
        )
      ],
    );
  }
}
