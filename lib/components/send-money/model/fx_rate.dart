class FxRateResponse {
  bool? status;
  String? responseCode;
  String? message;
  List<FxRate>? data;

  FxRateResponse({this.status, this.responseCode, this.message, this.data});

  FxRateResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FxRate>[];
      json['data'].forEach((v) {
        data!.add(new FxRate.fromJson(v));
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

class FxRate {
  String? currency;
  double? rate;
  String? countryName;

  FxRate({
    this.currency,
    this.rate,
    this.countryName,
  });

  FxRate.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    rate = json['rate'];
    countryName = json['countryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['rate'] = this.rate;
    data['countryName'] = this.countryName;
    return data;
  }

  static getList(List<dynamic>? json) {
    List<Map<String, dynamic>> beneficiary =
        List<Map<String, dynamic>>.from(json ?? []);
    return List.generate(
        beneficiary.length, (index) => FxRate.fromJson(beneficiary[index]));
  }
}
