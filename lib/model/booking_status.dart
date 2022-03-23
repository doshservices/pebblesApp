// api response of Booking status

class BookingStatus {
  String? message;
  Data? data;
  String? status;

  BookingStatus({this.status = 'success', this.message, this.data});

  BookingStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'] != null ? json['status'] : 'success';
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? bookingStatus;
  bool? isBooked;
  List<Null>? dateList;
  String? createdAt;
  String? paymentStatus;
  String? sId;
  String? apartmentOwnerId;
  String? apartmentId;
  String? checkInDate;
  String? checkOutDate;
  int? bookingAmount;
  int? numberOfGuests;
  String? bookingUserId;
  int? iV;

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
    bookingStatus = json['bookingStatus'];
    isBooked = json['isBooked'];
    if (json['dateList'] != null) {
      dateList = <Null>[];
      json['dateList'].forEach((v) {
        //dateList!.add(new Null.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    paymentStatus = json['paymentStatus'];
    sId = json['_id'];
    apartmentOwnerId = json['apartmentOwnerId'];
    apartmentId = json['apartmentId'];
    checkInDate = json['checkInDate'];
    checkOutDate = json['checkOutDate'];
    bookingAmount = json['bookingAmount'];
    numberOfGuests = json['numberOfGuests'];
    bookingUserId = json['bookingUserId'];
    iV = json['__v'];
  }
}
