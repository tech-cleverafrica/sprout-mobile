import 'package:dio/dio.dart';

import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/pay-bills/model/biller_group_model.dart';
import 'package:sprout_mobile/src/components/pay-bills/model/biller_model.dart';
import 'package:sprout_mobile/src/components/pay-bills/model/biller_package_model.dart';
import 'package:sprout_mobile/src/public/widgets/custom_loader.dart';
import '../../../api-setup/api_setup.dart';
import '../repository/pay_bills_repositoryimpl.dart';

class PayBillsService {
  Future<AppResponse<List<BillerGroup>>> getBillerGroups() async {
    Response response =
        await locator<PayBillsRepositoryImpl>().getBillerGroups();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"] == "success") {
      print(":::::::::$responseBody");
      return AppResponse<List<BillerGroup>>(true, statusCode, responseBody,
          BillerGroup.getList(responseBody["responseData"]));
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<List<Biller>>> getBillers(String route) async {
    Response response =
        await locator<PayBillsRepositoryImpl>().getBillers(route);
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
      Map<String, dynamic> requestBody,
      String route,
      String loadingMessage) async {
    CustomLoader.show(message: loadingMessage);
    Response response =
        await locator<PayBillsRepositoryImpl>().getPackages(requestBody, route);
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

  Future<AppResponse<dynamic>> lookup(Map<String, dynamic> requestBody,
      String route, String loadingMessage) async {
    CustomLoader.show(message: loadingMessage);
    Response response =
        await locator<PayBillsRepositoryImpl>().lookup(requestBody, route);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"] == "success") {
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> makePayment(Map<String, dynamic> requestBody,
      String route, String loadingMessage) async {
    CustomLoader.show(message: loadingMessage);
    Response response =
        await locator<PayBillsRepositoryImpl>().makePayment(requestBody, route);
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
