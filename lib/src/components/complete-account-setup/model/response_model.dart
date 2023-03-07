class RequestVerificationResponseModel {
  String? accessToken;
  String? refreshToken;
  int? expires;

  RequestVerificationResponseModel(
      {this.accessToken, this.refreshToken, this.expires});

  RequestVerificationResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    expires = json['expires'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['expires'] = this.expires;
    return data;
  }
}
