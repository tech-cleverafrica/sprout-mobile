class PaymentLinkRespose {
  bool? status;
  String? message;
  List<PaymentLink>? data;

  PaymentLinkRespose({this.status, this.message, this.data});

  PaymentLinkRespose.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PaymentLink>[];
      json['data'].forEach((v) {
        data!.add(new PaymentLink.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentLink {
  String? id;
  String? userID;
  String? agentID;
  num? amount;
  String? currency;
  String? fullName;
  String? description;
  String? redirect;
  String? refId;
  String? paymentLinkUrl;
  String? type;
  bool? paid;
  String? transactionID;
  String? sessionId;
  String? fee;
  String? bankCode;
  String? bankName;
  String? accountNumber;
  String? accountName;
  String? narration;
  String? domain;
  String? status;
  String? settledBy;
  String? subAccount;
  String? businessName;
  String? transactionTime;
  String? createdAt;
  String? updatedAt;

  PaymentLink({
    this.id,
    this.userID,
    this.agentID,
    this.amount,
    this.currency,
    this.fullName,
    this.description,
    this.redirect,
    this.refId,
    this.paymentLinkUrl,
    this.type,
    this.paid,
    this.transactionID,
    this.sessionId,
    this.fee,
    this.bankCode,
    this.bankName,
    this.accountNumber,
    this.accountName,
    this.narration,
    this.domain,
    this.status,
    this.settledBy,
    this.subAccount,
    this.businessName,
    this.transactionTime,
    this.createdAt,
    this.updatedAt,
  });

  PaymentLink.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    agentID = json['agentID'];
    amount = json['amount'];
    currency = json['currency'];
    fullName = json['fullName'];
    description = json['description'];
    redirect = json['redirect'];
    refId = json['refId'];
    paymentLinkUrl = json['paymentLinkUrl'];
    type = json['type'];
    paid = json['paid'];
    transactionID = json['transactionID'];
    sessionId = json['sessionId'];
    fee = json['fee'];
    bankCode = json['bankCode'];
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    accountName = json['accountName'];
    narration = json['narration'];
    domain = json['domain'];
    status = json['status'];
    settledBy = json['settledBy'];
    subAccount = json['subAccount'];
    businessName = json['businessName'];
    transactionTime = json['transactionTime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['agentID'] = this.agentID;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['fullName'] = this.fullName;
    data['description'] = this.description;
    data['redirect'] = this.redirect;
    data['refId'] = this.refId;
    data['paymentLinkUrl'] = this.paymentLinkUrl;
    data['type'] = this.type;
    data['paid'] = this.paid;
    data['transactionID'] = this.transactionID;
    data['sessionId'] = this.sessionId;
    data['fee'] = this.fee;
    data['bankCode'] = this.bankCode;
    data['bankName'] = this.bankName;
    data['accountNumber'] = this.accountNumber;
    data['accountName'] = this.accountName;
    data['narration'] = this.narration;
    data['domain'] = this.domain;
    data['status'] = this.status;
    data['settledBy'] = this.settledBy;
    data['subAccount'] = this.subAccount;
    data['businessName'] = this.businessName;
    data['transactionTime'] = this.transactionTime;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

  static getList(List<dynamic>? json) {
    List<Map<String, dynamic>> paymentLink =
        List<Map<String, dynamic>>.from(json ?? []);
    return List.generate(paymentLink.length,
        (index) => PaymentLink.fromJson(paymentLink[index]));
  }
}
