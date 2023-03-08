import 'dart:io';

class HelpRepository {
  getCategories() async {}
  getOverview() async {}
  getIssues(int size, String param) async {}
  getPendingIssues(int size) async {}
  reopenIssue(Map<String, dynamic> requestBody, String id) async {}
}
