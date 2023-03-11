class CategoriesResponse {
  bool? status;
  String? responseCode;
  String? message;
  List<Categories>? data;

  CategoriesResponse({this.status, this.responseCode, this.message, this.data});

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Categories>[];
      json['data'].forEach((v) {
        data!.add(new Categories.fromJson(v));
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

class Categories {
  String? id;
  String? category;
  String? name;
  String? createdAt;
  String? updatedAt;

  Categories({
    this.id,
    this.category,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

  static getList(List<dynamic>? json) {
    List<Map<String, dynamic>> category =
        List<Map<String, dynamic>>.from(json ?? []);
    return List.generate(
        category.length, (index) => Categories.fromJson(category[index]));
  }
}
