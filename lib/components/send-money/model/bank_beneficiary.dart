class BeneficiaryResponse {
  bool? status;
  String? responseCode;
  String? message;
  List<Beneficiary>? data;

  BeneficiaryResponse(
      {this.status, this.responseCode, this.message, this.data});

  BeneficiaryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Beneficiary>[];
      json['data'].forEach((v) {
        data!.add(new Beneficiary.fromJson(v));
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

class Beneficiary {
  String? id;
  String? userID;
  String? nickname;
  String? beneficiaryBank;
  String? beneficiaryName;
  String? accountNumber;
  String? bankCode;

  Beneficiary(
      {this.id,
      this.userID,
      this.nickname,
      this.beneficiaryBank,
      this.beneficiaryName,
      this.accountNumber,
      this.bankCode});

  Beneficiary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    nickname = json['nickname'];
    beneficiaryBank = json['beneficiaryBank'];
    beneficiaryName = json['beneficiaryName'];
    accountNumber = json['accountNumber'];
    bankCode = json['bankCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['nickname'] = this.nickname;
    data['beneficiaryBank'] = this.beneficiaryBank;
    data['beneficiaryName'] = this.beneficiaryName;
    data['accountNumber'] = this.accountNumber;
    data['bankCode'] = this.bankCode;
    return data;
  }

  static getList(List<dynamic>? json) {
    List<Map<String, dynamic>> beneficiary =
        List<Map<String, dynamic>>.from(json ?? []);
    return List.generate(beneficiary.length,
        (index) => Beneficiary.fromJson(beneficiary[index]));
  }
}
