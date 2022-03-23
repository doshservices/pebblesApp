import 'package:http/http.dart';
import 'dart:convert';
import 'package:pebbles/model/apartment_model.dart';
import 'package:pebbles/config.dart' as config;
import 'package:pebbles/model/http_exception.dart';

/// Apartments API requests and responses
class ApartmentAPI {
  String token;

  ApartmentAPI({required this.token});

  /// get Apartment by location
  Future<ApartmentModel> searchApartmentWithLocation(String location) async {
    try {
      var uri = Uri.parse(
          '${config.baseUrl}/apartments-one/search?apartmentSearch=$location');

      final response = await get(
        uri,
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      var resData = json.decode(response.body);
      if (response.statusCode != 200) {
        throw HttpException(resData["message"]);
      }

      // convert json response to ApartmentModel object
      ApartmentModel apartmentModel = ApartmentModel.fromJson(resData);

      return apartmentModel;
    } catch (error) {
      ApartmentModel apartmentModel =
          ApartmentModel(message: error.toString(), status: "error");

      return apartmentModel;
    }
  }

  /// get Apartment by id
  Future<ApartmentModel> getApartmentById(String id) async {
    try {
      var uri = Uri.parse('${config.baseUrl}/apartments/$id');

      final response = await get(
        uri,
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      var resData = json.decode(response.body);
      if (response.statusCode != 200) {
        throw HttpException(resData["message"]);
      }

      // convert json response to ApartmentModel object
      ApartmentModel apartmentModel = ApartmentModel.fromJson(resData);

      return apartmentModel;
    } catch (error) {
      ApartmentModel apartmentModel =
          ApartmentModel(message: error.toString(), status: "error");

      return apartmentModel;
    }
  }
}
