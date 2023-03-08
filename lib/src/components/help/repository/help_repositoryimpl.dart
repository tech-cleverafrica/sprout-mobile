import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/api/api.dart';
import 'package:sprout_mobile/src/api/api_constant.dart';
import 'package:sprout_mobile/src/components/help/repository/help_repository.dart';

class HelpRepositoryImpl implements HelpRepository {
  final Api api = Get.find<Api>();
  final storage = GetStorage();

  @override
  getCategories() async {
    try {
      return await api.dio.get(issueCategories);
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
      return await api.dio.get(issueOverview + agentId);
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
      return await api.dio.get('$issues$size&agentId=$agentId&status=$param');
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
      return await api.dio.get('$pendingIssues$size&agentId=$agentId');
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }
}
