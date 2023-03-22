import 'package:dio/dio.dart';

import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/profile/repository/profile_repositoryimpl.dart';
import 'package:sprout_mobile/src/public/widgets/custom_loader.dart';
import '../../../api-setup/api_setup.dart';

class ProfileService {
  Future<AppResponse<dynamic>> sendOtp(
      Map<String, dynamic> requestBody, String loadingMessage) async {
    CustomLoader.show(message: loadingMessage);
    Response response =
        await locator<ProfileRepositoryImpl>().sendOtp(requestBody);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> changePin(
      Map<String, dynamic> requestBody, String loadingMessage) async {
    CustomLoader.show(message: loadingMessage);
    Response response =
        await locator<ProfileRepositoryImpl>().changePin(requestBody);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> createPin(
      Map<String, dynamic> requestBody, String loadingMessage) async {
    CustomLoader.show(message: loadingMessage);
    Response response =
        await locator<ProfileRepositoryImpl>().createPin(requestBody);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> changePassword(
      Map<String, dynamic> requestBody, String loadingMessage) async {
    CustomLoader.show(message: loadingMessage);
    Response response =
        await locator<ProfileRepositoryImpl>().changePassword(requestBody);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> updateProfilePicture(
      Map<String, dynamic> requestBody) async {
    Response response = await locator<ProfileRepositoryImpl>()
        .updateProfilePicture(requestBody);
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> logout(
      Map<String, dynamic> requestBody, String loadingMessage) async {
    CustomLoader.show(message: loadingMessage);
    Response response =
        await locator<ProfileRepositoryImpl>().logout(requestBody);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }
}
