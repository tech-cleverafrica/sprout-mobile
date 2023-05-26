import 'package:dio/dio.dart';

import 'package:sprout_mobile/api/api_response.dart';
import 'package:sprout_mobile/components/pay-bills/model/biller_group_model.dart';
import 'package:sprout_mobile/components/pay-bills/model/biller_model.dart';
import 'package:sprout_mobile/components/pay-bills/model/biller_package_model.dart';
import 'package:sprout_mobile/components/authentication/service/auth_service.dart';
import 'package:sprout_mobile/public/widgets/custom_loader.dart';
import 'package:sprout_mobile/repository/preference_repository.dart';
import 'package:sprout_mobile/utils/constants.dart';
import '../../../api-setup/api_setup.dart';
import '../repository/pay_bills_repositoryimpl.dart';
import 'package:get/get.dart' as get_accessor;

class PayBillsService {
  final PreferenceRepository preferenceRepository =
      get_accessor.Get.put(PreferenceRepository());

  Future<AppResponse<List<BillerGroup>>> getBillerGroups() async {
    bool canLogin = await preferenceRepository.getBooleanPref(IS_LOGGED_IN);
    Response response =
        await locator.get<PayBillsRepositoryImpl>().getBillerGroups();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"] == "success") {
      print(":::::::::$responseBody");
      return AppResponse<List<BillerGroup>>(true, statusCode, responseBody,
          BillerGroup.getList(responseBody["responseData"]));
    } else if (statusCode == 999 && canLogin) {
      await locator.get<AuthService>().refreshUserToken();
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<List<Biller>>> getBillers(String route) async {
    Response response =
        await locator.get<PayBillsRepositoryImpl>().getBillers(route);
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"] == "success") {
      print(":::::::::$responseBody");
      return AppResponse<List<Biller>>(true, statusCode, responseBody,
          Biller.getList(responseBody["responseData"]));
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<List<BillerPackage>>> getPackages(
      Map<String, dynamic> requestBody, String route) async {
    CustomLoader.show();
    Response response = await locator
        .get<PayBillsRepositoryImpl>()
        .getPackages(requestBody, route);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"] == "success") {
      print(":::::::::$responseBody");
      return AppResponse<List<BillerPackage>>(true, statusCode, responseBody,
          BillerPackage.getList(responseBody["responseData"]));
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> lookup(
      Map<String, dynamic> requestBody, String route) async {
    CustomLoader.show();
    Response response =
        await locator.get<PayBillsRepositoryImpl>().lookup(requestBody, route);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"] == "success") {
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> makePayment(
      Map<String, dynamic> requestBody, String route) async {
    CustomLoader.show();
    Response response = await locator
        .get<PayBillsRepositoryImpl>()
        .makePayment(requestBody, route);
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