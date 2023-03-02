//auth
const String loginUrl = "auth/api/v1/mobile/token";
//user
const String userDetailsUrl = "user-management/api/v1/";

apiResponse(String? message, [String? responseCode]) {
  return {
    "status": false,
    "message": message ?? "An error occurred please try again",
    "responseCode": responseCode ?? "000"
  };
}
