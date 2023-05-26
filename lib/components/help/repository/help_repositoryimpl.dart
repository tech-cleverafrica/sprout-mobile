import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/api/api.dart';
import 'package:sprout_mobile/api/api_constant.dart';
import 'package:sprout_mobile/components/help/repository/help_repository.dart';

class HelpRepositoryImpl implements HelpRepository {
  final Api api = Get.find<Api>();
  final storage = GetStorage();

  @override
  getCategories() async {
    try {
      return await api.dio.get(issueCategoriesUrl);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  getSubCategories(id) async {
    try {
      return await api.dio.get(issueSubCategoriesUrl + id);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  getOverview() async {
    try {
      String agentId = storage.read("agentId");
      return await api.dio.get(issueOverviewUrl + agentId);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  getIssues(int size, String param) async {
    try {
      String agentId = storage.read("agentId");
      return await api.dio
          .get('$issuesUrl$size&agentId=$agentId&status=$param');
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  getPendingIssues(int size) async {
    try {
      String agentId = storage.read("agentId");
      return await api.dio.get('$pendingIssuesUrl$size&agentId=$agentId');
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  reopenIssue(requestBody, String id) async {
    try {
      return await api.dio
          .post(updateIssueUrl + id + '/reopen', data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  updateIssue(requestBody, String id) async {
    try {
      return await api.dio.put(updateIssueUrl + id, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  submitIssue(requestBody) async {
    try {
      return await api.dio.post(submitIssueUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  submitDispenseError(requestBody) async {
    try {
      return await api.dio.post(submitDispenseErrorIssueUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }
}
