import 'package:http/http.dart';
import 'dart:convert';
import 'package:pebbles/model/booking_model.dart';

import 'package:pebbles/config.dart' as config;
import 'package:pebbles/model/booking_status.dart';
import 'package:pebbles/model/http_exception.dart';
import 'package:pebbles/screens/dashboard/bookings/bookings.dart';

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
          BookingModel(status: "error", message: "Could not get bookings data");

      return bookingModel;
    }
  }

  /// Create booking
  Future<BookingStatus> createBooking(Booking apartmentBooking) async {
    try {
      var data = jsonEncode({
        "apartmentOwnerId": apartmentBooking.apartmentOwnerId!.sId,
        "apartmentId": apartmentBooking.apartmentId!.sId,
        "checkInDate": apartmentBooking.checkInDate,
        "checkOutDate": apartmentBooking.checkOutDate,
        "bookingAmount": apartmentBooking.bookingAmount,
        "numberOfGuests": apartmentBooking.numberOfGuests
      });

      var uri = Uri.parse('${config.baseUrl}/bookings/create-booking');

      final response = await post(uri,
          headers: {
            "content-type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: data);

      var resData = json.decode(response.body);
      if (response.statusCode != 200) {
        throw HttpException(resData["message"]);
      }

      print(response.body);

      // convert json response to BookingStatus object
      BookingStatus bookingStatus = BookingStatus.fromJson(resData);

      return bookingStatus;
    } catch (error) {
      BookingStatus bookingStatus =
          BookingStatus(status: "error", message: error.toString());

      return bookingStatus;
    }
  }

  /// Cancel booking
  Future<BookingModel> cancelBooking(String bookingId) async {
    try {
      var uri =
          Uri.parse('${config.baseUrl}/bookings/cancel-booking/$bookingId');

      final response = await get(uri, headers: {
        "content-type": "application/json",
        "Authorization": "Bearer $token"
      });

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

  /// pay for pending booking
  Future<String> payForBookingWithFlutterwave(String bookingId) async {
    try {
      var uri = Uri.parse(
          '${config.baseUrl}/bookings/pay-for/booking?bookingId=$bookingId&paymentMethod=FLUTTERWAVE');

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

      // convert json response
      String paymentURL = resData["data"]["booking"];

      return paymentURL;
    } catch (error) {
      throw "Error, something went wrong";
    }
  }

  /// pay for pending booking
  Future<String> verifyBookingPaymentWithFlutterwave(String reference) async {
    try {
      var uri =
          Uri.parse('${config.baseUrl}/bookings/verify-payment/$reference');

      final response = await get(
        uri,
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      var resData = json.decode(response.body);

      print(resData);
      print(response.body);

      if (response.statusCode != 200) {
        throw HttpException(resData["message"]);
      }

      // convert json response
      String paymentURL = resData["data"]["booking"];

      return paymentURL;
    } catch (error) {
      throw "Error, something went wrong";
    }
  }
}
