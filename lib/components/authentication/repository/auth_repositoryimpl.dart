import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/api/api.dart';
import 'package:sprout_mobile/api/api_constant.dart';
import 'package:sprout_mobile/components/authentication/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Api api = Get.find<Api>();

  @override
  signin(requestBody) async {
    try {
      return await api.dio.post(loginUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  getUserDetails() async {
    try {
      return await api.dio.get(
        userDetailsUrl,
      );
    } on DioError catch (e) {
      return api.handleError(e);
    }
  }

  @override
  emailConfirmation(requestBody) async {
    try {
      return await api.dio.post(confirmEmailUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  resetPassword(Map<String, dynamic> requestBody) async {
    try {
      return await api.dio.post(resetPasswordUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  verifyEmail(Map<String, dynamic> requestBody) async {
    try {
      return await api.dio.post(verifyEmailUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  createUser(Map<String, dynamic> requestBody) async {
    try {
      return await api.dio.post(createUserUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  refreshToken(requestBody) async {
    try {
      return await api.dio.post(refreshTokenUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }
}
