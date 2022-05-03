import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'dart:io' as Io;

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pebbles/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/http_exception.dart';
import '../model/user_model.dart';

import '../config.dart' as config;

class Auth with ChangeNotifier {
  String? _token;
  String? _accessTokenType;
  DateTime? _expiryDate;
  String? _userId;
  String? fullName, phoneNumber, userEmail;
  UserModel user = UserModel();

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    if (_userId != null) {
      return _userId;
    }
    return null;
  }

  Future<void> signUp(UserModel user, String otp) async {
    var data;

    data = jsonEncode({
      "fullName": user.fullName,
      "email": user.email,
      "password": user.password,
      "phoneNumber": user.phoneNumber,
      "otp": otp,
      "googleSigned": "false",
      "role": user.role,
      "businessName": user.businessName
    });

    try {
      var uri = Uri.parse('${config.baseUrl}/api/users');

      final response = await http.post(
        uri,
        headers: {"content-type": "application/json"},
        body: data,
      );
      var resData = jsonDecode(response.body);

      print(response.statusCode);
      print(resData);
      if (response.statusCode != 200) {
        print(resData["message"]["message"].toString());
        throw HttpException(resData["message"]["message"].toString());
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProfile(UserModel currentUser) async {
    var data;
    print(currentUser.email);
    if (currentUser.role == Role_Individual) {
      data = jsonEncode({
        "phone": currentUser.phoneNumber,
        "role": currentUser.role,
        "individualUser": {
          // "fullName": currentUser.individualFullName,
        }
      });
    }

    if (currentUser.role == Role_Business) {
      data = jsonEncode({
        "phone": currentUser.phoneNumber,
        "role": currentUser.role,
      });
    }

    try {
      var uri = Uri.parse('${config.baseUrl}/auth/users');

      final response = await http.put(
        uri,
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: data,
      );

      var resData = jsonDecode(response.body);

      print(resData);
      if (resData["status"].toString().toUpperCase() != "ACTIVE") {
        throw resData["message"];
      }
    } on HttpException catch (error) {
      throw error;
    }
  }

  Future<void> signIn(String email, String password) async {
    var data = jsonEncode({
      "loginId": email.trim(),
      "password": password,
    });
    try {
      var uri = Uri.parse('${config.baseUrl}/api/users/login');

      final response = await http.post(
        uri,
        headers: {"content-type": "application/json"},
        body: data,
      );

      var resData = jsonDecode(response.body);
      print(response.statusCode);
      print(resData);

      if (response.statusCode != 200) {
        throw resData["message"];
      }

      _token = resData["data"]["token"];

      user.isVerified = resData["data"]["userDetails"]["isVerified"];

      user.id = resData["data"]["userDetails"]["_id"];
      user.fullName = resData["data"]["userDetails"]["fullName"];
      user.email = resData["data"]["userDetails"]["email"];

      user.phoneNumber = resData["data"]["userDetails"]["phoneNumber"];
      user.profilePhoto = resData["data"]["userDetails"]["profilePictureUrl"];
      user.role = resData["data"]["userDetails"]["role"];
      user.password = password;

      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'isVerified': user.isVerified,
        'token': token,
        'id': user.id,
        'email': user.email,
        'fullName': user.fullName,
        'phoneNumber': user.phoneNumber,
        'profilePhoto': user.profilePhoto,
        'role': user.role
      });

      prefs.setString("userData", userData);
    } on SocketException {
      throw "No Internet connection";
    } on HttpException {
      throw "No Service found";
    } on FormatException {
      throw "Invalid data format";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> sendOtp(String email) async {
    var data = jsonEncode({
      "email": email,
    });
    try {
      var uri = Uri.parse('${config.baseUrl}/api/send-token');

      final response = await http.post(
        uri,
        headers: {"content-type": "application/json"},
        body: data,
      );

      var resData = jsonDecode(response.body);
      print(response.statusCode);
      print(resData);

      if (response.statusCode != 200) {
        throw resData["message"];
      }
    } on SocketException {
      throw "No Internet connection";
    } on HttpException {
      throw "No Service found";
    } on FormatException {
      throw "Invalid data format";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> forgotPassword(String email) async {
    var data = jsonEncode({
      "email": email.trim(),
    });
    try {
      var uri = Uri.parse('${config.baseUrl}/api/users/forgot-password');
      final response = await http.post(
        uri,
        headers: {"content-type": "application/json"},
        body: data,
      );
      var resData = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw resData["message"];
      }
      return resData["message"];
    } on SocketException {
      throw "No Internet connection";
    } on HttpException {
      throw "No Service found";
    } on FormatException {
      throw "Invalid data format";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> forgotPasswordCompletion(
      String token, String newPassword) async {
    var data = jsonEncode({"token": token, "newPassword": newPassword});
    try {
      var uri = Uri.parse('${config.baseUrl}/api/users/reset-password');

      final response = await http.post(
        uri,
        headers: {"content-type": "application/json"},
        body: data,
      );
      var resData = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw resData["message"];
      }

      user.password = newPassword;

      notifyListeners();
      return resData["message"];
    } on SocketException {
      throw "No Internet connection";
    } on HttpException {
      throw "No Service found";
    } on FormatException {
      throw "Invalid data format";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> changePassword(String oldPassword, String newPassword) async {
    var data =
        jsonEncode({"oldPassword": oldPassword, "newPassword": newPassword});
    try {
      var uri = Uri.parse('${config.baseUrl}/api/users/change-password');

      final response = await http.post(
        uri,
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: data,
      );

      var resData = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw resData["message"];
      }

      user.password = newPassword;

      notifyListeners();

      return resData["message"];
    } on SocketException {
      throw "No Internet connection";
    } on HttpException {
      throw "No Service found";
    } on FormatException {
      throw "Invalid data format";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> resendVerificationCode(String email) async {
    var data = jsonEncode({
      "email": email.trim(),
    });
    try {
      var uri = Uri.parse(
          '${config.baseUrl}/users/$email/resend-email-verification-code');

      final response = await http.post(
        uri,
        headers: {"content-type": "application/json"},
        body: data,
      );
      print(response.statusCode);

      var resData = jsonDecode(response.body);
      print(resData);
      if (response.statusCode != 200) {
        throw resData["message"];
      }
      return resData["message"];
    } on SocketException {
      throw "No Internet connection";
    } on HttpException {
      throw "No Service found";
    } on FormatException {
      throw "Invalid data format";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> verifyEmail(String email, String code) async {
    var data = jsonEncode({"email": email.trim(), "code": code});
    try {
      var uri = Uri.parse('${config.baseUrl}/users/verify-email');
      final response = await http.post(
        uri,
        headers: {"content-type": "application/json"},
        body: data,
      );
      print(response.statusCode);

      var resData = jsonDecode(response.body);
      print(resData);
      if (response.statusCode != 200) {
        throw resData["message"];
      }
      return resData["message"];
    } on SocketException {
      throw "No Internet connection";
    } on HttpException {
      throw "No Service found";
    } on FormatException {
      throw "Invalid data format";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool?> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(milliseconds: 2000), () {
      if (!prefs.containsKey("userData")) {
        return false;
      }

      final extractedUserData = json.decode(prefs.getString("userData")!);

      _token = extractedUserData["token"];
      user.id = extractedUserData["id"];
      user.email = extractedUserData["email"];
      user.fullName = extractedUserData["fullName"];
      user.phoneNumber = extractedUserData["phoneNumber"];
      user.profilePhoto = extractedUserData["profilePhoto"];
      notifyListeners();
      // _autoLogout();
      return true;
    });
  }

  Future<UserModel> fetchProfile() async {
    try {
      var uri = Uri.parse('${config.baseUrl}/api/users/${user.id}');

      final response = await http.get(
        uri,
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      var resData = jsonDecode(response.body);
      print(resData);
      print(response.statusCode);
      if (response.statusCode == 401) {
        throw HttpException("401");
      }

      if (response.statusCode != 200) {
        throw resData["message"];
      }

      user.phoneNumber = resData["data"]["user"]["phoneNumber"];
      user.email = resData["data"]["user"]["email"];
      // user.firstName = resData["data"]["user"]["firstName"];
      // user.lastName = resData["data"]["user"]["lastName"];

      user.profilePhoto = resData["data"]["user"]["profilePictureUrl"];
      user.id = resData["data"]["user"]["_id"];
      user.role = resData["data"]["user"]["role"];

      notifyListeners();
      return user;
    } on SocketException {
      throw "No Internet connection";
    } on HttpException {
      throw "No Service found";
    } on FormatException {
      throw "Invalid data format";
    } catch (e) {
      throw e.toString();
    }
  }

  // Future<List<AddressModel>> fetchAddresses() async {
  //   String url = "${config.baseUrl}/address";
  //   print("JHJJH");
  //   try {
  //     List<AddressModel> addresses = [];
  //     final response = await http.get(
  //       url,
  //       headers: {
  //         "content-type": "application/json",
  //         "Authorization": "Bearer $token"
  //       },
  //     );
  //     var resData = jsonDecode(response.body.toString());
  //     print(resData);
  //     print(response.statusCode);
  //     if (response.statusCode == 401) {
  //       throw HttpException("401");
  //     }
  //     List<dynamic> entities = resData["data"]["addresses"];
  //     entities.forEach((entity) {
  //       AddressModel address = AddressModel();
  //       address.id = entity['_id'];
  //       address.address = entity["address"];
  //       address.city = entity["city"];
  //       address.contact = entity["contact"];
  //       address.deliverTo = entity["deliverTo"];
  //       address.state = entity["state"];

  //       addresses.add(address);
  //     });

  //     return addresses;
  //   } catch (error) {
  //     print(error);
  //     throw error;
  //   }
  // }

  // Future<void> createAddress(AddressModel address) async {
  //   var data;

  //   data = jsonEncode({
  //     "state": address.state,
  //     "city": " ",
  //     "address": address.address,
  //     "contact": address.contact,
  //     "deliverTo": address.deliverTo
  //   });

  //   try {
  //     final response = await http.post(
  //       "${config.baseUrl}/address",
  //       headers: {
  //         "content-type": "application/json",
  //         "Authorization": "Bearer $token"
  //       },
  //       body: data,
  //     );
  //     var resData = jsonDecode(response.body);

  //     print(response.statusCode);
  //     print(resData);
  //     if (response.statusCode != 200) {
  //       print(resData["message"].toString());
  //       throw HttpException(resData["message"].toString());
  //     }
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  // Future<void> updateAddress(AddressModel address) async {
  //   var data;

  //   data = jsonEncode({
  //     "state": address.state,
  //     "city": address.city,
  //     "address": address.address,
  //     "contact": address.contact,
  //     "deliverTo": address.deliverTo
  //   });

  //   try {
  //     final response = await http.put(
  //       "${config.baseUrl}/address/${address.id}",
  //       headers: {
  //         "content-type": "application/json",
  //         "Authorization": "Bearer $token"
  //       },
  //       body: data,
  //     );
  //     var resData = jsonDecode(response.body);

  //     print(response.statusCode);
  //     print(resData);
  //     if (response.statusCode != 200) {
  //       print(resData["message"].toString());
  //       throw HttpException(resData["message"].toString());
  //     }
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  Future<void> updateUser(UserModel userModel) async {
    var data;

    data = jsonEncode({
      // "firstName": userModel.firstName,
      // "lastName": userModel.lastName,
      "email": userModel.email,
      "phoneNumber": userModel.phoneNumber,
      "fullName": userModel.fullName
    });

    try {
      var uri = Uri.parse('${config.baseUrl}/users');

      final response = await http.put(
        uri,
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: data,
      );
      var resData = jsonDecode(response.body);
      print(resData.toString());

      print(response.statusCode);
      print(resData);
      if (response.statusCode != 200) {
        print(resData["message"].toString());
        throw resData["message"].toString();
      }
      user.email = userModel.email;
      user.phoneNumber = userModel.phoneNumber;
      user.fullName = userModel.fullName;
      // user.firstName = userModel.firstName;
      // user.lastName = userModel.lastName;
      notifyListeners();
    } on SocketException {
      throw "No Internet connection";
    } on HttpException {
      throw "No Service found";
    } on FormatException {
      throw "Invalid data format";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> uploadProfilePicture({
    String? url,
  }) async {
    var data;

    data = jsonEncode({
      "imageUrl": url,
    });
    try {
      var uri = Uri.parse('${config.baseUrl}/users/upload/user/image');

      final response = await http.put(
        uri,
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: data,
      );
      var resData = jsonDecode(response.body);

      print(response.body);

      if (response.statusCode != 200) {
        throw HttpException("Error Uploading Image");
      }

      notifyListeners();
    } on SocketException {
      throw "No Internet connection";
    } on HttpException {
      throw "No Service found";
    } on FormatException {
      throw "Invalid data format";
    } catch (e) {
      throw e.toString();
    }
  }

  void logout() async {
    _token = null;
    _userId = "";
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("userData");
  }
}
