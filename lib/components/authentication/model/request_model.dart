class SignInRequestModel {
  String? username;
  String? password;
  String? agentDeviceId;
  SignInRequestModel({required String username, password, agentDeviceId});
  SignInRequestModel.login(
      {required this.username,
      required this.password,
      required this.agentDeviceId});
  SignInRequestModel.toJson(Map<String, dynamic> json)
      : username = json["username"],
        password = json["password"],
        agentDeviceId = json["agentDeviceId"];
}
