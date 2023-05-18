class IssuesSubCategoryResponse {
  bool? status;
  String? responseCode;
  String? message;
  List<IssuesSubCategory>? data;

  IssuesSubCategoryResponse(
      {this.status, this.responseCode, this.message, this.data});

  IssuesSubCategoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <IssuesSubCategory>[];
      json['data'].forEach((v) {
        data!.add(new IssuesSubCategory.fromJson(v));
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

class IssuesSubCategory {
  String? id;
  String? categoryId;
  String? subcategory;
  String? name;
  var sla;
  var createdAt;
  var updatedAt;

  IssuesSubCategory({
    this.id,
    this.categoryId,
    this.subcategory,
    this.name,
    this.sla,
    this.createdAt,
    this.updatedAt,
  });

  IssuesSubCategory.fromJson(Map<String, dynamic> json) {
    id = json["id"] ?? '-';
    categoryId = json["categoryId"] ?? '-';
    subcategory = json["subcategory"] ?? '-';
    name = json["name"] ?? '-';
    sla = json["sla"] ?? '-';
    createdAt = json["createdAt"] ?? '-';
    updatedAt = json["updatedAt"] ?? '-';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['subcategory'] = this.subcategory;
    data['sla'] = this.sla;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

  static getList(List<dynamic>? json) {
    List<Map<String, dynamic>> subCategory =
        List<Map<String, dynamic>>.from(json ?? []);
    return List.generate(subCategory.length,
        (index) => IssuesSubCategory.fromJson(subCategory[index]));
  }
}
