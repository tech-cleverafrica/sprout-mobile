class Wallet {
  bool? status;
  String? responseCode;
  String? message;
  Data? data;

  Wallet({this.status, this.responseCode, this.message, this.data});

  Wallet.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['responseCode'] = this.responseCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userID;
  int? walletID;
  double? balance;
  String? updatedAt;

  Data({this.userID, this.walletID, this.balance, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    walletID = json['walletID'];
    balance = json['balance'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['walletID'] = this.walletID;
    data['balance'] = this.balance;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
