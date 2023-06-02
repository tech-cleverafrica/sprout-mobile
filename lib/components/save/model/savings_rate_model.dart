// ignore_for_file: non_constant_identifier_names
class SavingsRateResponse {
  bool? status;
  String? responseCode;
  String? message;
  List<SavingsRate>? data;

  SavingsRateResponse(
      {this.status, this.responseCode, this.message, this.data});

  SavingsRateResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SavingsRate>[];
      json['data'].forEach((v) {
        data!.add(new SavingsRate.fromJson(v));
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

class SavingsRate {
  var id;
  var tenure;
  var target;
  var locked;
  var fixed;
  String? created_at;
  String? updated_at;

  SavingsRate({
    this.id,
    this.tenure,
    this.target,
    this.locked,
    this.fixed,
    this.created_at,
    this.updated_at,
  });

  SavingsRate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenure = json['tenure'];
    target = json['target'];
    locked = json['locked'];
    fixed = json['fixed'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tenure'] = this.tenure;
    data['target'] = this.target;
    data['locked'] = this.locked;
    data['fixed'] = this.fixed;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    return data;
  }

  static getList(List<dynamic>? json) {
    List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(json ?? []);
    return List.generate(
        data.length, (index) => SavingsRate.fromJson(data[index]));
  }
}
