class SignInResponseModel {
  String? accessToken;
  String? refreshToken;
  int? expires;

  SignInResponseModel({this.accessToken, this.refreshToken, this.expires});

  SignInResponseModel.fromJson(Map<String, dynamic> json) {
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
