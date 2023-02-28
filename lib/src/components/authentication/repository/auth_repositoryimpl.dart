import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/api/api.dart';
import 'package:sprout_mobile/src/api/api_constant.dart';
import 'package:sprout_mobile/src/components/authentication/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Api api = Get.find<Api>();

  @override
  signin(requestBody) async {
    try {
      return await api.dio.post(loginUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    }
  }
}
