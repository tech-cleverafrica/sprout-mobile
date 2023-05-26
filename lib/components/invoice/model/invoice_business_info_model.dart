class InvoiceBusinessInfoResponse {
  bool? status;
  String? responseCode;
  String? message;
  InvoiceBusinessInfo? data;

  InvoiceBusinessInfoResponse(
      {this.status, this.responseCode, this.message, this.data});

  InvoiceBusinessInfoResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    data = json['data'] != null
        ? new InvoiceBusinessInfo.fromJson(json['data'])
        : null;
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

class InvoiceBusinessInfo {
  String? agentID;
  String? bankName;
  String? businessAddress;
  String? businessLogo;
  String? businessName;
  String? createdAt;
  String? email;
  String? firstName;
  String? id;
  String? lastName;
  String? paymentAccountNumber;
  String? phone;
  String? updatedAt;
  String? userID;

  InvoiceBusinessInfo(
      {this.agentID,
      this.bankName,
      this.businessAddress,
      this.businessLogo,
      this.businessName,
      this.createdAt,
      this.email,
      this.firstName,
      this.id,
      this.lastName,
      this.paymentAccountNumber,
      this.phone,
      this.updatedAt,
      this.userID});

  InvoiceBusinessInfo.fromJson(Map<String, dynamic> json) {
    agentID = json['agentID'];
    bankName = json['bankName'];
    businessAddress = json['businessAddress'];
    businessLogo = json['businessLogo'];
    businessName = json['businessName'];
    createdAt = json['createdAt'];
    email = json['email'];
    firstName = json['firstName'];
    id = json['id'];
    lastName = json['lastName'];
    paymentAccountNumber = json['paymentAccountNumber'];
    phone = json['phone'];
    updatedAt = json['updatedAt'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['agentID'] = this.agentID;
    data['bankName'] = this.bankName;
    data['businessAddress'] = this.businessAddress;
    data['businessLogo'] = this.businessLogo;
    data['businessName'] = this.businessName;
    data['createdAt'] = this.createdAt;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['id'] = this.id;
    data['lastName'] = this.lastName;
    data['paymentAccountNumber'] = this.paymentAccountNumber;
    data['phone'] = this.phone;
    data['updatedAt'] = this.updatedAt;
    data['userID'] = this.userID;
    return data;
  }

  static getList(List<dynamic>? json) {
    List<Map<String, dynamic>> invoiceBusinessInfo =
        List<Map<String, dynamic>>.from(json ?? []);
    return List.generate(invoiceBusinessInfo.length,
        (index) => InvoiceBusinessInfo.fromJson(invoiceBusinessInfo[index]));
  }
}
