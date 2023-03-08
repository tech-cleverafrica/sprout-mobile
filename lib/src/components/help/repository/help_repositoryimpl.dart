import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:sprout_mobile/src/api/api.dart';
import 'package:sprout_mobile/src/api/api_constant.dart';
import 'package:sprout_mobile/src/components/help/repository/help_repository.dart';

class HelpRepositoryImpl implements HelpRepository {
  final Api api = Get.find<Api>();

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
}
