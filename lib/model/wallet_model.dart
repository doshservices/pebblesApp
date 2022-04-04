/// Wallet response

class WalletModel {
  String status = "success";
  String? message;
  Data? data;

  WalletModel({this.message, this.data, this.status = 'success'});

  WalletModel.fromJson(Map<String, dynamic> json) {
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

class Data {
  Wallet? wallet;

  Data({this.wallet});

  Data.fromJson(Map<String, dynamic> json) {
    wallet =
        json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wallet != null) {
      data['wallet'] = this.wallet!.toJson();
    }
    return data;
  }
}

class Wallet {
  int? availableBalance;
  bool? frozen;
  String? sId;
  String? userId;
  int? iV;
  int? withdrawableBalance;

  Wallet(
      {this.availableBalance,
      this.frozen,
      this.sId,
      this.userId,
      this.iV,
      this.withdrawableBalance});

  Wallet.fromJson(Map<String, dynamic> json) {
    availableBalance = json['availableBalance'];
    frozen = json['frozen'];
    sId = json['_id'];
    userId = json['userId'];
    iV = json['__v'];
    withdrawableBalance = json['withdrawableBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['availableBalance'] = this.availableBalance;
    data['frozen'] = this.frozen;
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['__v'] = this.iV;
    data['withdrawableBalance'] = this.withdrawableBalance;
    return data;
  }
}
