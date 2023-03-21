class BillerResponse {
  bool? error;
  String? status;
  String? message;
  String? responseCode;
  Biller? data;

  BillerResponse({this.status, this.responseCode, this.message, this.data});

  BillerResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    data = json['data'] != null ? new Biller.fromJson(json['data']) : null;
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

class Biller {
  int? id;
  String? name;
  String? slug;
  int? groupId;
  bool? skipValidation;
  bool? handleWithProductCode;
  bool? isRestricted;
  bool? hideInstitution;

  Biller({
    this.id,
    this.name,
    this.slug,
    this.groupId,
    this.skipValidation,
    this.handleWithProductCode,
    this.isRestricted,
    this.hideInstitution,
  });

  Biller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    groupId = json['groupId'];
    skipValidation = json['skipValidation'];
    handleWithProductCode = json['handleWithProductCode'];
    isRestricted = json['isRestricted'];
    hideInstitution = json['hideInstitution'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['groupId'] = this.groupId;
    data['skipValidation'] = this.skipValidation;
    data['handleWithProductCode'] = this.handleWithProductCode;
    data['isRestricted'] = this.isRestricted;
    data['hideInstitution'] = this.hideInstitution;
    return data;
  }

  static getList(List<dynamic>? json) {
    List<Map<String, dynamic>> category =
        List<Map<String, dynamic>>.from(json ?? []);
    return List.generate(
        category.length, (index) => Biller.fromJson(category[index]));
  }
}
