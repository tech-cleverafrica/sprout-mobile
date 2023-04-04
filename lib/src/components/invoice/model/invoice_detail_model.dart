class InvoiceDetail {
  String? id;
  String? invoiceNo;
  String? userID;
  BusinessInfo? businessInfo;
  Customer? customer;
  String? customerID;
  List<InvoiceContent>? invoiceContent;
  String? dueDate;
  String? invoiceDate;
  String? note;
  String? paymentAccountNumber;
  num? tax;
  num? discount;
  num? subTotal;
  num? total;
  int? partialPaidAmount;
  List<PaymentHistory>? paymentHistory;
  String? paymentStatus;
  String? invoicePDFUrl;
  bool? downloaded;
  String? createdAt;
  String? updatedAt;
  bool? expired;

  InvoiceDetail(
      {this.id,
      this.invoiceNo,
      this.userID,
      this.businessInfo,
      this.customer,
      this.customerID,
      this.invoiceContent,
      this.dueDate,
      this.invoiceDate,
      this.note,
      this.paymentAccountNumber,
      this.tax,
      this.discount,
      this.subTotal,
      this.total,
      this.partialPaidAmount,
      this.paymentHistory,
      this.paymentStatus,
      this.invoicePDFUrl,
      this.downloaded,
      this.createdAt,
      this.updatedAt,
      this.expired});

  InvoiceDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceNo = json['invoiceNo'];
    userID = json['userID'];
    businessInfo = json['businessInfo'] != null
        ? new BusinessInfo.fromJson(json['businessInfo'])
        : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    customerID = json['customerID'];
    if (json['invoiceContent'] != null) {
      invoiceContent = <InvoiceContent>[];
      json['invoiceContent'].forEach((v) {
        invoiceContent!.add(new InvoiceContent.fromJson(v));
      });
    }
    dueDate = json['dueDate'];
    invoiceDate = json['invoiceDate'];
    note = json['note'];
    paymentAccountNumber = json['paymentAccountNumber'];
    tax = json['tax'];
    discount = json['discount'];
    subTotal = json['subTotal'];
    total = json['total'];
    partialPaidAmount = json['partialPaidAmount'];
    if (json['paymentHistory'] != null) {
      paymentHistory = <PaymentHistory>[];
      json['paymentHistory'].forEach((v) {
        paymentHistory!.add(new PaymentHistory.fromJson(v));
      });
    }
    paymentStatus = json['paymentStatus'];
    invoicePDFUrl = json['invoicePDFUrl'];
    downloaded = json['downloaded'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    expired = json['expired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoiceNo'] = this.invoiceNo;
    data['userID'] = this.userID;
    if (this.businessInfo != null) {
      data['businessInfo'] = this.businessInfo!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['customerID'] = this.customerID;
    if (this.invoiceContent != null) {
      data['invoiceContent'] =
          this.invoiceContent!.map((v) => v.toJson()).toList();
    }
    data['dueDate'] = this.dueDate;
    data['invoiceDate'] = this.invoiceDate;
    data['note'] = this.note;
    data['paymentAccountNumber'] = this.paymentAccountNumber;
    data['tax'] = this.tax;
    data['discount'] = this.discount;
    data['subTotal'] = this.subTotal;
    data['total'] = this.total;
    data['partialPaidAmount'] = this.partialPaidAmount;
    if (this.paymentHistory != null) {
      data['paymentHistory'] =
          this.paymentHistory!.map((v) => v.toJson()).toList();
    }
    data['paymentStatus'] = this.paymentStatus;
    data['invoicePDFUrl'] = this.invoicePDFUrl;
    data['downloaded'] = this.downloaded;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['expired'] = this.expired;
    return data;
  }
}

class BusinessInfo {
  String? id;
  String? userID;
  String? firstName;
  String? lastName;
  String? agentID;
  String? businessName;
  String? businessAddress;
  String? bankName;
  String? phone;
  String? email;
  String? businessLogo;
  String? paymentAccountNumber;
  String? createdAt;
  String? updatedAt;

  BusinessInfo(
      {this.id,
      this.userID,
      this.firstName,
      this.lastName,
      this.agentID,
      this.businessName,
      this.businessAddress,
      this.bankName,
      this.phone,
      this.email,
      this.businessLogo,
      this.paymentAccountNumber,
      this.createdAt,
      this.updatedAt});

  BusinessInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    agentID = json['agentID'];
    businessName = json['businessName'];
    businessAddress = json['businessAddress'];
    bankName = json['bankName'];
    phone = json['phone'];
    email = json['email'];
    businessLogo = json['businessLogo'];
    paymentAccountNumber = json['paymentAccountNumber'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['agentID'] = this.agentID;
    data['businessName'] = this.businessName;
    data['businessAddress'] = this.businessAddress;
    data['bankName'] = this.bankName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['businessLogo'] = this.businessLogo;
    data['paymentAccountNumber'] = this.paymentAccountNumber;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Customer {
  String? id;
  String? fullName;
  String? email;
  String? phone;
  String? address;
  String? registrarID;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.id,
      this.fullName,
      this.email,
      this.phone,
      this.address,
      this.registrarID,
      this.createdAt,
      this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    registrarID = json['registrarID'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['registrarID'] = this.registrarID;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class InvoiceContent {
  String? itemTitle;
  num? itemQuantity;
  num? itemUnitPrice;
  num? itemTotalPrice;

  InvoiceContent(
      {this.itemTitle,
      this.itemQuantity,
      this.itemUnitPrice,
      this.itemTotalPrice});

  InvoiceContent.fromJson(Map<String, dynamic> json) {
    itemTitle = json['itemTitle'];
    itemQuantity = json['itemQuantity'];
    itemUnitPrice = json['itemUnitPrice'];
    itemTotalPrice = json['itemTotalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemTitle'] = this.itemTitle;
    data['itemQuantity'] = this.itemQuantity;
    data['itemUnitPrice'] = this.itemUnitPrice;
    data['itemTotalPrice'] = this.itemTotalPrice;
    return data;
  }
}

class PaymentHistory {
  num? date;
  num? amount;

  PaymentHistory({this.date, this.amount});

  PaymentHistory.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['amount'] = this.amount;
    return data;
  }
}
