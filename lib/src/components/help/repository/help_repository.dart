class HelpRepository {
  getCategories() async {}
  getSubCategories(String id) async {}
  getOverview() async {}
  getIssues(int size, String param) async {}
  getPendingIssues(int size) async {}
  reopenIssue(Map<String, dynamic> requestBody, String id) async {}
  updateIssue(Map<String, dynamic> requestBody, String id) async {}
  submitIssue(Map<String, dynamic> requestBody) async {}
  submitDispenseError(Map<String, dynamic> requestBody) async {}
}
