class AppResponse<T> {
  late bool status;
  late String responseCode;
  late int statusCode;
  late String message;
  var data;

  AppResponse(isSuccess, int? statusCode, Map<String, dynamic> response,
      [data]) {
    this.status = isSuccess ?? false;
    this.responseCode = response["responseCode"] ?? "100001";
    this.statusCode = statusCode ?? 000;
    this.message = getResponseMessage(response, isSuccess);
    this.data = data ?? "";
  }

  String getResponseMessage(Map<String, dynamic> response, isSuccessful) {
    String message;
    if (isSuccessful) {
      message = response["message"] ?? "Success";
    } else {
      message = response["message"] ?? "an error occurred";
    }
    return message;
  }
}
