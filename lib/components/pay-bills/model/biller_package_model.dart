class BillerPackageResponse {
  bool? error;
  String? status;
  String? message;
  String? responseCode;
  BillerPackage? data;

  BillerPackageResponse(
      {this.status, this.responseCode, this.message, this.data});

  BillerPackageResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    data =
        json['data'] != null ? new BillerPackage.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['status'] = this.status;
    data['responseCode'] = this.responseCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class BillerPackage {
  int? id;
  String? name;
  String? slug;
  var amount;
  int? billerId;

  BillerPackage({
    this.id,
    this.name,
    this.slug,
    this.amount,
    this.billerId,
  });

  BillerPackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    amount = json['amount'];
    billerId = json['billerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['amount'] = this.amount;
    data['billerId'] = this.billerId;
    return data;
  }

  static getList(List<dynamic>? json) {
    List<Map<String, dynamic>> category =
        List<Map<String, dynamic>>.from(json ?? []);
    return List.generate(
        category.length, (index) => BillerPackage.fromJson(category[index]));
  }
}
