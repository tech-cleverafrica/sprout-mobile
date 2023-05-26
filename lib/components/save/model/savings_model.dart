// ignore_for_file: non_constant_identifier_names
class SavingsResponse {
  bool? status;
  String? responseCode;
  String? message;
  List<Savings>? data;

  SavingsResponse({this.status, this.responseCode, this.message, this.data});

  SavingsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Savings>[];
      json['data'].forEach((v) {
        data!.add(new Savings.fromJson(v));
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

class Savings {
  String? id;
  String? userID;
  String? agentID;
  String? portfolioName;
  String? type;
  String? source;
  String? cardToken;
  String? startDate;
  String? maturityDate;
  String? nextDebitDate;
  num? targetAmount;
  num? startAmount;
  num? currentAmount;
  num? interestRate;
  num? interestAccrued;
  num? expectedInterest;
  String? debitFrequency;
  num? tenure;
  bool? rollover;
  String? status;
  bool? visible;
  String? createdAt;
  String? updatedAt;

  Savings({
    this.id,
    this.userID,
    this.agentID,
    this.portfolioName,
    this.type,
    this.source,
    this.cardToken,
    this.startDate,
    this.maturityDate,
    this.nextDebitDate,
    this.targetAmount,
    this.startAmount,
    this.currentAmount,
    this.interestRate,
    this.interestAccrued,
    this.expectedInterest,
    this.debitFrequency,
    this.tenure,
    this.rollover,
    this.status,
    this.visible,
    this.createdAt,
    this.updatedAt,
  });

  Savings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    agentID = json['agentID'];
    portfolioName = json['portfolioName'];
    type = json['type'];
    source = json['source'];
    cardToken = json['cardToken'];
    startDate = json['startDate'];
    maturityDate = json['maturityDate'];
    nextDebitDate = json['nextDebitDate'];
    targetAmount = json['targetAmount'];
    startAmount = json['startAmount'];
    currentAmount = json['currentAmount'];
    interestRate = json['interestRate'];
    interestAccrued = json['interestAccrued'];
    expectedInterest = json['expectedInterest'];
    debitFrequency = json['debitFrequency'];
    tenure = json['tenure'];
    rollover = json['rollover'];
    status = json['status'];
    visible = json['visible'] ?? true;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['agentID'] = this.agentID;
    data['portfolioName'] = this.portfolioName;
    data['type'] = this.type;
    data['source'] = this.source;
    data['cardToken'] = this.cardToken;
    data['startDate'] = this.startDate;
    data['maturityDate'] = this.maturityDate;
    data['nextDebitDate'] = this.nextDebitDate;
    data['targetAmount'] = this.targetAmount;
    data['startAmount'] = this.startAmount;
    data['currentAmount'] = this.currentAmount;
    data['interestRate'] = this.interestRate;
    data['interestAccrued'] = this.interestAccrued;
    data['expectedInterest'] = this.expectedInterest;
    data['debitFrequency'] = this.debitFrequency;
    data['tenure'] = this.tenure;
    data['rollover'] = this.rollover;
    data['status'] = this.status;
    data['visible'] = this.visible;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

  static getList(List<dynamic>? json) {
    List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(json ?? []);
    return List.generate(data.length, (index) => Savings.fromJson(data[index]));
  }
}
