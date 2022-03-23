import 'dart:convert';

import 'package:pebbles/bloc/services.dart';
import 'package:pebbles/model/apartment_model.dart';
import 'package:pebbles/provider/apartment_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApartmentBloc {
  /// get apartments near current user with Location
  Future<ApartmentModel> getApartmentsByUserLocation(
      String currentAddress) async {
    ApartmentModel apartmentModel = ApartmentModel();

    final userToken = await Services.getUserToken();

    // api request to get apartments near current user
    ApartmentAPI apartmentAPI = ApartmentAPI(token: userToken);

    apartmentModel =
        await apartmentAPI.searchApartmentWithLocation(currentAddress);
    // add else statement

    return apartmentModel;
  }
}
