import 'dart:convert';

import 'package:pebbles/model/apartment_model';
import 'package:pebbles/provider/apartment_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApartmentBloc {
  /// get apartments near current user with Location
  Future<ApartmentModel> getApartmentsByUserLocation(
      String currentAddress) async {
    ApartmentModel apartmentModel = ApartmentModel();

    final preferences = await SharedPreferences.getInstance();
    final userPreferences = preferences.getString("userData");
    final userJsonData = json.decode(userPreferences!);

    final userToken = userJsonData["token"];

    // api request to get apartments near current user
    ApartmentAPI apartmentAPI = ApartmentAPI(token: userToken);

    apartmentModel =
        await apartmentAPI.searchApartmentWithLocation(currentAddress);
    // add else statement

    return apartmentModel;
  }
}
