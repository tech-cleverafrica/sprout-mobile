import 'package:dio/dio.dart';
import 'package:sprout_mobile/api-setup/api_setup.dart';
import 'package:sprout_mobile/api/api_response.dart';
import 'package:sprout_mobile/components/save/model/savings_model.dart';
import 'package:sprout_mobile/components/save/model/savings_rate_model.dart';
import 'package:sprout_mobile/components/save/repository/savings_repositoryImpl.dart';
import 'package:sprout_mobile/public/widgets/custom_loader.dart';

class SavingsService {
  Future<AppResponse<List<Savings>>> getPlans() async {
    Response response = await locator.get<SavingsRepositoryImpl>().getPlans();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<List<Savings>>(true, statusCode, responseBody,
          Savings.getList(responseBody["data"]));
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<List<SavingsRate>>> getRateOptions() async {
    CustomLoader.show();
    Response response =
        await locator.get<SavingsRepositoryImpl>().getRateOptions();
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<List<SavingsRate>>(true, statusCode, responseBody,
          SavingsRate.getList(responseBody["data"]));
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> getSavingsSummary(
      Map<String, dynamic> requestBody) async {
    CustomLoader.show();
    Response response = await locator
        .get<SavingsRepositoryImpl>()
        .getSavingsSummary(requestBody);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> createSavings(
      Map<String, dynamic> requestBody) async {
    CustomLoader.show();
    Response response =
        await locator.get<SavingsRepositoryImpl>().createSavings(requestBody);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> createTopUp(
      Map<String, dynamic> requestBody) async {
    CustomLoader.show();
    Response response =
        await locator.get<SavingsRepositoryImpl>().createTopUp(requestBody);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }
}
