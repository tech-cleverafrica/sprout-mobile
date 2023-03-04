//auth
const String loginUrl = "auth/api/v1/mobile/token";
const String confirmEmailUrl = "auth/api/v1/otp";
const String resetPasswordUrl = "auth/api/v1/mobile/reset-password";
//user
const String userDetailsUrl = "user-management/api/v1/users/me";

apiResponse(String? message, [String? responseCode]) {
  return {
    "status": false,
    "message": message ?? "An error occurred please try again",
    "responseCode": responseCode ?? "000"
  };
}
