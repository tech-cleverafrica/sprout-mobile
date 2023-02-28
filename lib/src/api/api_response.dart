class AppResponse<T> {
  late bool isSuccessful;
  late int status;
  late String responseCode;
  late String message;
  T? data;

  AppResponse(isSuccess, int? statusCode, Map<String, dynamic> response,
      [data]) {
    this.isSuccessful = isSuccess ?? false;
    this.status = statusCode ?? 000;
    this.responseCode = response["responseCode"] ?? "100001";
    this.message = getResponseMessage(response, isSuccess);
    this.data = data;
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
