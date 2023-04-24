import 'package:dio/dio.dart';
import 'package:get/get.dart' as get_accessor;
import 'package:get_storage/get_storage.dart';

import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/authentication/model/response_model.dart';
import 'package:sprout_mobile/src/components/authentication/model/user.dart';
import 'package:sprout_mobile/src/components/authentication/view/sign_in_screen.dart';
import 'package:sprout_mobile/src/components/profile/repository/profile_repositoryimpl.dart';
import 'package:sprout_mobile/src/repository/preference_repository.dart';
import 'package:sprout_mobile/src/utils/constants.dart';
import 'package:sprout_mobile/src/utils/global_function.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';
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
      Map<String, dynamic> requestBody) async {
    CustomLoader.show();
    Response response =
        await locator.get<AuthRepositoryImpl>().signin(requestBody);
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      String accessToken = responseBody["data"]["accessToken"];
      int expireIn = responseBody["data"]["expires"];
      String refreshToken = responseBody["data"]["refreshToken"];
      preferenceRepository.setStringPref(accessTokenKey, accessToken);
      preferenceRepository.setIntPref(expiresInKey, expireIn);
      preferenceRepository.setStringPref(refreshTokenKey, refreshToken);
      api.baseOptions.headers.addAll({"Authorization": "Bearer $accessToken"});
      return AppResponse<SignInResponseModel>(
          true,
          statusCode,
          responseBody["data"],
          SignInResponseModel.fromJson(responseBody['data']));
    }
    CustomLoader.dismiss();
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> getUserDetails() async {
    Response response =
        await locator.get<AuthRepositoryImpl>().getUserDetails();
    CustomLoader.dismiss();
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
      storage.write('profilePicture', user.data!.profilePicture ?? "");
      storage.write('phoneNumber', user.data!.phoneNumber ?? "");
      storage.write('email', user.data!.email ?? "");
      storage.write('agentId', user.data!.agentId ?? "");
      storage.write('businessName', user.data!.businessName ?? "");
      storage.write('address', user.data!.address ?? "");
      storage.write('city', user.data!.city ?? "");
      storage.write('state', user.data!.state ?? "");
      storage.write('displayedAccount', user.data!.displayedAccount ?? "");
      storage.write('bankTID', user.data!.bankTID ?? "");
      storage.write('terminalId', user.data!.terminalId ?? "");
      storage.write('deviceSerialNumber', user.data!.deviceSerialNumber ?? "");
      storage.write('approvalStatus', user.data!.approvalStatus ?? "");
      storage.write('hasPin', user.data!.hasPin ?? "");
      storage.write('metaMapInfo', user.data!.metaMapInfo ?? "");

      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }

    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> confirmEmail(
      Map<String, dynamic> requestBody) async {
    CustomLoader.show();
    Response response =
        await locator.get<AuthRepositoryImpl>().emailConfirmation(requestBody);
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
      Map<String, dynamic> requestBody) async {
    CustomLoader.show();
    Response response =
        await locator.get<AuthRepositoryImpl>().resetPassword(requestBody);
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

  Future<AppResponse<dynamic>> refreshUserToken() async {
    Response response = await locator.get<AuthRepositoryImpl>().refreshToken({
      "refreshToken": await preferenceRepository.getStringPref(refreshTokenKey)
    });
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(response.data["data"]);
      String accessToken = responseBody["data"]["accessToken"];
      int expireIn = responseBody["data"]["expires"];
      String refreshToken = responseBody["data"]["refreshToken"];
      preferenceRepository.setStringPref(accessTokenKey, accessToken);
      preferenceRepository.setIntPref(expiresInKey, expireIn);
      preferenceRepository.setStringPref(refreshTokenKey, refreshToken);
      api.baseOptions.headers.addAll({"Authorization": "Bearer $accessToken"});
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    } else if (statusCode == 999) {
      logout({});
    }
    return AppResponse(false, statusCode, responseBody, response.data["data"]);
  }

  Future<AppResponse<dynamic>> verifyEmail(
      Map<String, dynamic> requestBody) async {
    CustomLoader.show();
    Response response =
        await locator.get<AuthRepositoryImpl>().verifyEmail(requestBody);
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
      Map<String, dynamic> requestBody) async {
    CustomLoader.show();
    Response response =
        await locator.get<AuthRepositoryImpl>().createUser(requestBody);
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

  Future<AppResponse<dynamic>> logout(Map<String, dynamic> requestBody) async {
    Response response =
        await locator.get<ProfileRepositoryImpl>().logout(requestBody);
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    setLoginStatus(false);
    showAutoBiometricsOnLoginPage(false);
    pushUntil(page: SignInScreen());
    return AppResponse(false, statusCode, responseBody);
  }
}
