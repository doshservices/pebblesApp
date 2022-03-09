import 'package:http/http.dart';
import 'dart:convert';
import 'package:pebbles/model/booking_model.dart';

import 'package:pebbles/config.dart' as config;
import 'package:pebbles/model/http_exception.dart';

/// All api endpoints towards Booking
class BookingAPI {
  String token;

  BookingAPI({required this.token});

  /// Get booking by user id
  Future<BookingModel> getBookingByUserId() async {
    try {
      var uri = Uri.parse('${config.baseUrl}/bookings/booking-by-userId');

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

      // convert json response to BookingModel object
      BookingModel bookingModel = BookingModel.fromJson(resData);

      return bookingModel;
    } catch (error) {
      BookingModel bookingModel =
          BookingModel(status: "error", message: error.toString());

      return bookingModel;
    }
  }
}
