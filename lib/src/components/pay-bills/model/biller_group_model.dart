class BillerGroupResponse {
  bool? error;
  String? status;
  String? message;
  String? responseCode;
  BillerGroup? data;

  BillerGroupResponse(
      {this.status, this.responseCode, this.message, this.data});

  BillerGroupResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    data = json['data'] != null ? new BillerGroup.fromJson(json['data']) : null;
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

class BillerGroup {
  int? id;
  String? name;
  String? slug;

  BillerGroup({
    this.id,
    this.name,
    this.slug,
  });

  BillerGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }

  static getList(List<dynamic>? json) {
    List<Map<String, dynamic>> category =
        List<Map<String, dynamic>>.from(json ?? []);
    return List.generate(
        category.length, (index) => BillerGroup.fromJson(category[index]));
  }
}
