/// Apartment Model:
/// API response data
class ApartmentModel {
  String status = "success";
  String? message;
  Data? data;

  ApartmentModel({this.message, this.data, this.status = 'success'});

  ApartmentModel.fromJson(Map<String, dynamic> json) {
    // success request returns empty status
    try {
      status = json['status'];
    } catch (e) {
      status = 'success';
    }
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

/// Apartment data
class Data {
  /// valid for requests with a list of apartments
  List<Apartment>? apartments;

  /// valid for requests with single apartment
  Apartment? apartment;

  Data({this.apartments, this.apartment});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['apartments'] != null) {
      apartments = <Apartment>[];
      json['apartments'].forEach((v) {
        apartments!.add(new Apartment.fromJson(v));
      });
    }

    apartment = json['apartment'] != null
        ? new Apartment.fromJson(json['apartment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.apartments != null) {
      data['apartments'] = this.apartments!.map((v) => v.toJson()).toList();
    }

    if (this.apartment != null) {
      data['apartment'] = this.apartment!.toJson();
    }

    return data;
  }
}

/// Apartment class
class Apartment {
  List<String>? facilities;
  List<String>? apartmentImages;
  bool? isAvailable;
  String? sId;
  String? apartmentName;
  String? address;
  String? apartmentCountry;
  String? apartmentState;
  int? price;
  String? typeOfApartment;
  String? apartmentInfo;
  int? numberOfRooms;
  String? userId;
  int? iV;

  Apartment(
      {this.facilities,
      this.apartmentImages,
      this.isAvailable,
      this.sId,
      this.apartmentName,
      this.address,
      this.apartmentCountry,
      this.apartmentState,
      this.price,
      this.typeOfApartment,
      this.apartmentInfo,
      this.numberOfRooms,
      this.userId,
      this.iV});

  Apartment.fromJson(Map<String, dynamic> json) {
    facilities = json['facilities'].cast<String>();
    apartmentImages = json['apartmentImages'].cast<String>();
    isAvailable = json['isAvailable'];
    sId = json['_id'];
    apartmentName = json['apartmentName'];
    address = json['address'];
    apartmentCountry = json['apartmentCountry'];
    apartmentState = json['apartmentState'];
    price = json['price'];
    typeOfApartment = json['typeOfApartment'];
    apartmentInfo = json['apartmentInfo'];
    numberOfRooms = json['numberOfRooms'];
    userId = json['userId'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['facilities'] = this.facilities;
    data['apartmentImages'] = this.apartmentImages;
    data['isAvailable'] = this.isAvailable;
    data['_id'] = this.sId;
    data['apartmentName'] = this.apartmentName;
    data['address'] = this.address;
    data['apartmentCountry'] = this.apartmentCountry;
    data['apartmentState'] = this.apartmentState;
    data['price'] = this.price;
    data['typeOfApartment'] = this.typeOfApartment;
    data['apartmentInfo'] = this.apartmentInfo;
    data['numberOfRooms'] = this.numberOfRooms;
    data['userId'] = this.userId;
    data['__v'] = this.iV;
    return data;
  }
}
