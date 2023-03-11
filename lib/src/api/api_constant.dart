//auth
const String loginUrl = "auth/api/v1/mobile/token";
const String confirmEmailUrl = "auth/api/v1/otp";
const String resetPasswordUrl = "auth/api/v1/mobile/reset-password";
const String sendOtpdUrl = "auth/api/v1/otp";

//user
const String userDetailsUrl = "user-management/api/v1/users/me";
const String createUserUrl = "user-management/api/v1/users/agent";
const String requestVerificationUrl = "user-management/api/v1/users/";
const String uploadUrl = "user-management/api/v1/users/upload";
const String changePinUrl = "user-management/api/v1/users/pin/change";

//issue
const String issueCategoriesUrl = "resolution/api/v1/categories";
const String issueSubCategoriesUrl = "resolution/api/v1/subcategories/";
const String issueOverviewUrl = "resolution/api/v1/issues/overview?agentId=";
const String issuesUrl = "resolution/api/v1/issues?size=";
const String pendingIssuesUrl = "resolution/api/v1/issues/mobile?size=";
const String updateIssueUrl = "resolution/api/v1/issues/";
const String submitIssueUrl = "resolution/api/v1/issues";
const String submitDispenseErrorIssueUrl = "resolution/api/v1/issues/error";

//transactions
const String transactionsUrl = "transaction/api/v1/transactions/me";

//wallet
const String walletUrl = "wallet/api/v1/wallets/me";

//sendMoney
const String beneficiaryUrl = "transfer/api/v1/beneficiary";
const String banksUrl = "transfer/api/v1/banks";
const String transferMoney = "transfer/api/v1/disburse";
const String validateBankUrl = "transfer/api/v1/resolve/account";
const String makeTransferUrl = "transfer/api/v1/disburse";

apiResponse(String? message, [String? responseCode]) {
  return {
    "status": false,
    "message": message ?? "An error occurred please try again",
    "responseCode": responseCode ?? "000"
  };
}
