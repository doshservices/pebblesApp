// https://javiercbk.github.io/json_to_dart/

/// Booking Model
class BookingModel {
  String status = 'success';
  String? message;
  BookingsData? data;

  BookingModel({this.message, this.data, this.status = 'success'});

  BookingModel.fromJson(Map<String, dynamic> json) {
    try {
      status = json['status'];
    } catch (e) {
      status = 'success';
    }

    message = json['message'];
    data =
        json['data'] != null ? new BookingsData.fromJson(json['data']) : null;
  }
}

/// List of bookings
class BookingsData {
  List<Booking>? bookings = [];

  BookingsData({this.bookings});

  BookingsData.fromJson(Map<String, dynamic> json) {
    if (json['bookings'] != null) {
      bookings = <Booking>[];
      json['bookings'].forEach((v) {
        bookings!.add(new Booking.fromJson(v));
      });
    }
  }
}

class Booking {
  String? bookingStatus;
  bool? isBooked;
  List<String>? dateList;
  String? createdAt;
  String? paymentStatus;
  String? sId;
  ApartmentOwnerId? apartmentOwnerId;
  ApartmentId? apartmentId;
  String? checkInDate;
  String? checkOutDate;
  int? bookingAmount;
  int? numberOfGuests;
  ApartmentOwnerId? bookingUserId;
  int? iV;

  Booking(
      {this.bookingStatus,
      this.isBooked,
      this.dateList,
      this.createdAt,
      this.paymentStatus,
      this.sId,
      this.apartmentOwnerId,
      this.apartmentId,
      this.checkInDate,
      this.checkOutDate,
      this.bookingAmount,
      this.numberOfGuests,
      this.bookingUserId,
      this.iV});

  Booking.fromJson(Map<String, dynamic> json) {
    bookingStatus = json['bookingStatus'];
    isBooked = json['isBooked'];
    dateList = json['dateList'].cast<String>();
    createdAt = json['createdAt'];
    paymentStatus = json['paymentStatus'];
    sId = json['_id'];
    apartmentOwnerId = json['apartmentOwnerId'] != null
        ? new ApartmentOwnerId.fromJson(json['apartmentOwnerId'])
        : null;
    apartmentId = json['apartmentId'] != null
        ? new ApartmentId.fromJson(json['apartmentId'])
        : null;
    checkInDate = json['checkInDate'];
    checkOutDate = json['checkOutDate'];
    bookingAmount = json['bookingAmount'];
    numberOfGuests = json['numberOfGuests'];
    bookingUserId = json['bookingUserId'] != null
        ? new ApartmentOwnerId.fromJson(json['bookingUserId'])
        : null;
    iV = json['__v'];
  }
}

class ApartmentOwnerId {
  String? sId;
  String? fullName;

  ApartmentOwnerId({this.sId, this.fullName});

  ApartmentOwnerId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
  }
}

class ApartmentId {
  List<String>? apartmentImages;
  String? sId;
  String? apartmentName;

  ApartmentId({this.apartmentImages, this.sId, this.apartmentName});

  ApartmentId.fromJson(Map<String, dynamic> json) {
    apartmentImages = json['apartmentImages'].cast<String>();
    sId = json['_id'];
    apartmentName = json['apartmentName'];
  }
}
