import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as get_accessor;
import 'package:get_storage/get_storage.dart';

import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/authentication/model/response_model.dart';
import 'package:sprout_mobile/src/components/authentication/model/user.dart';
import 'package:sprout_mobile/src/repository/preference_repository.dart';
import 'package:sprout_mobile/src/utils/constants.dart';
import '../../../api-setup/api_setup.dart';
import '../../../api/api.dart';
import '../../../public/widgets/custom_loader.dart';
import '../../../reources/repository.dart';
import '../repository/auth_repositoryimpl.dart';

class AuthService {
  final Api api = get_accessor.Get.put(Api(Dio()));
  final Repository repository = get_accessor.Get.put(Repository());
  final storage = GetStorage();
  SignInResponseModel signInResponseModel =
      get_accessor.Get.put(SignInResponseModel(), permanent: true);
  final PreferenceRepository preferenceRepository =
      get_accessor.Get.put(PreferenceRepository());

  Future<AppResponse<SignInResponseModel>> signIn(
      Map<String, dynamic> requestBody, String loadingMessage) async {
    CustomLoader.show(message: loadingMessage);
    Response response = await locator<AuthRepositoryImpl>().signin(requestBody);
    CustomLoader.dismiss();

    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      CustomLoader.dismiss();
      String accessToken = responseBody["data"]["accessToken"];
      preferenceRepository.setStringPref(accessTokenKey, accessToken);
      api.baseOptions.headers.addAll({"Authorization": "Bearer $accessToken"});
      return AppResponse<SignInResponseModel>(
          true,
          statusCode,
          responseBody["data"],
          SignInResponseModel.fromJson(responseBody['data']));
    }

    return AppResponse(false, statusCode, responseBody[""]);
  }

  Future<AppResponse<dynamic>> getUserDetails() async {
    //  CustomLoader.show(message: "Getting customer details ...");
    Response response = await locator<AuthRepositoryImpl>().getUserDetails();
    // CustomLoader.dismiss();

    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      User user = User.fromJson(response.data);

      storage.write('userId', user.data!.id ?? "");
      storage.write('firstname', user.data!.firstName ?? "");
      storage.write("lastname", user.data!.lastName ?? "");
      storage.write('accountNumber', user.data!.accountNumber ?? "");
      storage.write('providusAccount', user.data!.providusAccountNumber ?? "");
      storage.write('wemaAccount', user.data!.wemaAccountNumber ?? "");

      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }

    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> confirmEmail(
      Map<String, dynamic> requestBody, String loadingMessage) async {
    CustomLoader.show(message: loadingMessage);
    Response response =
        await locator<AuthRepositoryImpl>().emailConfirmation(requestBody);
    print(response);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> resetPassword(
      Map<String, dynamic> requestBody, String loadingMessage) async {
    CustomLoader.show(message: loadingMessage);
    Response response =
        await locator<AuthRepositoryImpl>().resetPassword(requestBody);
    print(response);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> createUser(
      Map<String, dynamic> requestBody, String loadingMessage) async {
    CustomLoader.show(message: loadingMessage);
    Response response =
        await locator<AuthRepositoryImpl>().createUser(requestBody);
    print(response);
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
