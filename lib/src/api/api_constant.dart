//auth
const String loginUrl = "auth/api/v1/mobile/token";
const String confirmEmailUrl = "auth/api/v1/otp";
const String resetPasswordUrl = "auth/api/v1/mobile/reset-password";

//user
const String userDetailsUrl = "user-management/api/v1/users/me";
const String createUserUrl = "user-management/api/v1/users/agent";
const String requestVerificationUrl = "user-management/api/v1/users/";
const String uploadUrl = "user-management/api/v1/users/upload";

//issue
const String issueCategories = "resolution/api/v1/categories";
const String issueOverview = "resolution/api/v1/issues/overview?agentId=";
const String issues = "resolution/api/v1/issues?size=";
const String pendingIssues = "resolution/api/v1/issues/mobile?size=";

//transactions
const String transactionsUrl = "transaction/api/v1/transactions/me";

//wallet
const String walletUrl = "wallet/api/v1/wallets/me";

//sendMoney
const String beneficiaryUrl = "transfer/api/v1/beneficiary";

apiResponse(String? message, [String? responseCode]) {
  return {
    "status": false,
    "message": message ?? "An error occurred please try again",
    "responseCode": responseCode ?? "000"
  };
}
