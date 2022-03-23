import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pebbles/bloc/apartmentBloc.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/apartment_model.dart';
import 'package:pebbles/utils/shared/top_back_navigation_widget.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  ApartmentBloc apartmentBloc = ApartmentBloc();
  ApartmentModel _apartmentModel = ApartmentModel();
  String location = "";

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)?.settings.arguments as Map;
    location = data['location'];

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.fill,
            ),
            color: Colors.grey.withOpacity(0.2)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBackNavigationWidget(),
              Row(
                children: [
                  Text(
                    "Apartments in ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                        fontFamily: 'Gilroy'),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "$location",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                        fontFamily: 'Gilroy'),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
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
                    Navigator.of(context).pushReplacementNamed(kSearch,
                        arguments: {'location': value});
                  },
                  onChanged: (value) {
                    location = value;
                  },
                  initialValue: location,
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
                            Navigator.of(context).pushReplacementNamed(kSearch,
                                arguments: {'location': location});
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
              FutureBuilder(
                  future: apartmentBloc.getApartmentsByUserLocation(location),
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
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                _apartmentModel.data?.apartments?.length ?? 0,
                            itemBuilder: (context, index) {
                              return ApartmentListtile(
                                  apartment:
                                      _apartmentModel.data!.apartments![index]);
                            });
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Column(
                        children: [LinearProgressIndicator()],
                      );
                    }

                    return Container();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ApartmentListtile extends StatelessWidget {
  final Apartment? apartment;
  final formatCurrency = new NumberFormat("#,##0.00", "en_US");

  ApartmentListtile({Key? key, this.apartment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Image.asset(
            "assets/images/hotel.png",
            //width: 40,
            height: 100,
          ),
          contentPadding: EdgeInsets.all(0),
          title: Text(
            apartment?.apartmentName ?? "",
            style: TextStyle(
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w900,
                fontSize: 18.0),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
                '${apartment?.address}, ${apartment?.apartmentState}, ${apartment?.apartmentCountry}',
                style: TextStyle(fontFamily: 'Gilroy', fontSize: 16.0)),
          ),
          trailing: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text("N${formatCurrency.format(apartment?.price)}",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Gilroy',
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold)),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(kApartmentDetail,
                arguments: {'apartment': apartment});
          },
        ),
        Divider()
      ],
    );
  }
}
