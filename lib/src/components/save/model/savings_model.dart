// ignore_for_file: non_constant_identifier_names
class Savings {
  bool? status;
  String? responseCode;
  String? message;
  Data? data;

  Savings({this.status, this.responseCode, this.message, this.data});

  Savings.fromJson(Map<String, dynamic> json) {
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
  var id;
  String? savingsId;
  String? userId;
  String? portfolio_name;
  num? amount;
  String? start_date;
  String? source;
  String? maturity_date;
  num? start_amount;
  num? current_amount;
  num? interest_rate;
  num? interest_accrued;
  num? expected_interest;
  String? debit_frequency;
  num? tenure;
  String? type;
  bool? rollover;
  String? status;
  String? created_at;
  String? updated_at;

  Data({
    this.id,
    this.savingsId,
    this.userId,
    this.portfolio_name,
    this.amount,
    this.start_date,
    this.source,
    this.maturity_date,
    this.start_amount,
    this.current_amount,
    this.interest_rate,
    this.interest_accrued,
    this.expected_interest,
    this.debit_frequency,
    this.tenure,
    this.type,
    this.rollover,
    this.status,
    this.created_at,
    this.updated_at,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    savingsId = json['savingsId'];
    userId = json['userId'];
    portfolio_name = json['portfolio_name'];
    amount = json['amount'];
    start_date = json['start_date'];
    source = json['source'];
    maturity_date = json['maturity_date'];
    start_amount = json['start_amount'];
    current_amount = json['current_amount'];
    interest_rate = json['interest_rate'];
    interest_accrued = json['interest_accrued'];
    expected_interest = json['expected_interest'];
    debit_frequency = json['debit_frequency'];
    tenure = json['tenure'];
    type = json['type'];
    rollover = json['rollover'];
    status = json['status'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['savingsId'] = this.savingsId;
    data['userId'] = this.userId;
    data['portfolio_name'] = this.portfolio_name;
    data['amount'] = this.amount;
    data['start_date'] = this.start_date;
    data['source'] = this.source;
    data['maturity_date'] = this.maturity_date;
    data['start_amount'] = this.start_amount;
    data['current_amount'] = this.current_amount;
    data['interest_rate'] = this.interest_rate;
    data['interest_accrued'] = this.interest_accrued;
    data['expected_interest'] = this.expected_interest;
    data['debit_frequency'] = this.debit_frequency;
    data['tenure'] = this.tenure;
    data['type'] = this.type;
    data['rollover'] = this.rollover;
    data['status'] = this.status;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    return data;
  }
}
