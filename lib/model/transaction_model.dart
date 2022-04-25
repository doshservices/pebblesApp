class TransactionResponse {
  String? message;
  Data? data;
  String status = "success";

  TransactionResponse({this.message, this.data,  this.status = 'success'});

  TransactionResponse.fromJson(Map<String, dynamic> json) {
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
  List<Transactions>? transactions;

  Data({this.transactions});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  String? status;
  String? sId;
  String? userId;
  int? amount;
  String? reason;
  String? type;
  String? paymentDate;
  String? createdAt;
  int? iV;

  Transactions(
      {this.status,
      this.sId,
      this.userId,
      this.amount,
      this.reason,
      this.type,
      this.paymentDate,
      this.createdAt,
      this.iV});

  Transactions.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    userId = json['userId'];
    amount = json['amount'];
    reason = json['reason'];
    type = json['type'];
    paymentDate = json['paymentDate'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['amount'] = this.amount;
    data['reason'] = this.reason;
    data['type'] = this.type;
    data['paymentDate'] = this.paymentDate;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
