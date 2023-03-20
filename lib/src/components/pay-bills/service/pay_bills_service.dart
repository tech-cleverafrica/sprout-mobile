import 'package:dio/dio.dart';

import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/pay-bills/model/biller_group_model.dart';
import 'package:sprout_mobile/src/components/pay-bills/model/biller_model.dart';
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
}
