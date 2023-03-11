class Overview {
  bool? status;
  String? responseCode;
  String? message;
  Data? data;

  Overview({this.status, this.responseCode, this.message, this.data});

  Overview.fromJson(Map<String, dynamic> json) {
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
  int? total;
  int? reopened;
  int? pending;
  int? awaiting;
  int? resolved;

  Data({
    this.total,
    this.reopened,
    this.pending,
    this.awaiting,
    this.resolved,
  });

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    reopened = json['reopened'];
    pending = json['pending'];
    awaiting = json['awaiting'];
    resolved = json['resolved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['reopened'] = this.reopened;
    data['pending'] = this.pending;
    data['awaiting'] = this.awaiting;
    data['resolved'] = this.resolved;
    return data;
  }
}
