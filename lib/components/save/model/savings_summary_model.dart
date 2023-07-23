class SavingsSummary {
  bool? status;
  String? responseCode;
  String? message;
  Data? data;

  SavingsSummary({this.status, this.responseCode, this.message, this.data});

  SavingsSummary.fromJson(Map<String, dynamic> json) {
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
  num? savingsAmount;
  num? tenure;
  String? type;
  String? startDate;
  String? endDate;
  num? interestRate;
  String? debitFrequency;
  num? expectedInterestAmount;
  bool? rollover;

  Data(
      {this.savingsAmount,
      this.tenure,
      this.type,
      this.startDate,
      this.endDate,
      this.interestRate,
      this.debitFrequency,
      this.expectedInterestAmount});

  Data.fromJson(Map<String, dynamic> json) {
    savingsAmount = json['savingsAmount'];
    tenure = json['tenure'];
    type = json['type'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    interestRate = json['interestRate'];
    debitFrequency = json['debitFrequency'];
    expectedInterestAmount = json['expectedInterestAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['savingsAmount'] = this.savingsAmount;
    data['tenure'] = this.tenure;
    data['type'] = this.type;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['interestRate'] = this.interestRate;
    data['debitFrequency'] = this.debitFrequency;
    data['expectedInterestAmount'] = this.expectedInterestAmount;
    return data;
  }
}
