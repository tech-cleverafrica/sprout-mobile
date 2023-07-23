class InvoiceCustomerResponse {
  bool? status;
  String? responseCode;
  String? message;
  List<InvoiceCustomer>? data;

  InvoiceCustomerResponse(
      {this.status, this.responseCode, this.message, this.data});

  InvoiceCustomerResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <InvoiceCustomer>[];
      json['data'].forEach((v) {
        data!.add(new InvoiceCustomer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['responseCode'] = this.responseCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InvoiceCustomer {
  String? id;
  String? fullName;
  String? email;
  String? phone;
  String? address;
  String? registrarID;
  String? createdAt;
  String? updatedAt;

  InvoiceCustomer(
      {this.id,
      this.fullName,
      this.email,
      this.phone,
      this.address,
      this.registrarID,
      this.createdAt,
      this.updatedAt});

  InvoiceCustomer.fromJson(Map<String, dynamic> json) {
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

  static getList(List<dynamic>? json) {
    List<Map<String, dynamic>> invoiceCustomer =
        List<Map<String, dynamic>>.from(json ?? []);
    return List.generate(invoiceCustomer.length,
        (index) => InvoiceCustomer.fromJson(invoiceCustomer[index]));
  }
}
