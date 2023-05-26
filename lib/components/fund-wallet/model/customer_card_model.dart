class CustomerCard {
  String? id;
  String? userID;
  String? agentID;
  String? pan;
  String? cardHash;
  String? expiryMonth;
  String? expiryYear;
  String? issuingCountry;
  String? token;
  String? scheme;
  String? status;
  String? provider;
  String? createdAt;
  String? updatedAt;

  CustomerCard({
    this.id,
    this.userID,
    this.agentID,
    this.pan,
    this.cardHash,
    this.expiryMonth,
    this.expiryYear,
    this.issuingCountry,
    this.token,
    this.scheme,
    this.status,
    this.provider,
    this.createdAt,
    this.updatedAt,
  });

  CustomerCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    agentID = json['agentID'];
    pan = json['pan'];
    cardHash = json['cardHash'];
    expiryMonth = json['expiryMonth'];
    expiryYear = json['expiryYear'];
    issuingCountry = json['issuingCountry'];
    token = json['token'];
    scheme = json['scheme'];
    status = json['status'];
    provider = json['provider'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['agentID'] = this.agentID;
    data['pan'] = this.pan;
    data['cardHash'] = this.cardHash;
    data['expiryMonth'] = this.expiryMonth;
    data['expiryYear'] = this.expiryYear;
    data['issuingCountry'] = this.issuingCountry;
    data['token'] = this.token;
    data['scheme'] = this.scheme;
    data['status'] = this.status;
    data['provider'] = this.provider;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

  static getList(List<dynamic>? json) {
    List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(json ?? []);
    return List.generate(
        data.length, (index) => CustomerCard.fromJson(data[index]));
  }
}
