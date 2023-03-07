class RequestVerificationRequestModel {
  String? username;
  String? password;
  String? agentDeviceId;
  RequestVerificationRequestModel(
      {required String username, password, agentDeviceId});
  RequestVerificationRequestModel.login(
      {required this.username,
      required this.password,
      required this.agentDeviceId});
  RequestVerificationRequestModel.toJson(Map<String, dynamic> json)
      : username = json["username"],
        password = json["password"],
        agentDeviceId = json["agentDeviceId"];
}
