import 'package:http/http.dart';
import 'dart:convert';
import 'package:pebbles/model/apartment_model.dart';
import 'package:pebbles/config.dart' as config;
import 'package:pebbles/model/http_exception.dart';
import 'package:pebbles/model/wallet_model.dart';

/// Wallet API requests and responses
class WalletAPI {
  String token;

  WalletAPI({required this.token});

  /// get Wallet by location
  Future<WalletModel> getUserWallet() async {
    try {
      var uri = Uri.parse(
          '${config.baseUrl}/api/wallet');

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

      // convert json response to WalletModel object
      WalletModel walletModel = WalletModel.fromJson(resData);

      return walletModel;
    }
    
     catch (error) {
      WalletModel walletModel =
          WalletModel(message: error.toString(), status: "error");

      return walletModel;
    }
  }

}

