import 'package:dio/dio.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/save/repository/savings_repositoryImpl.dart';
import 'package:sprout_mobile/src/public/widgets/custom_loader.dart';

class SavingsService {
  Future<AppResponse<dynamic>> getPlans() async {
    Response response = await locator<SavingsRepositoryImpl>().getPlans();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }

    return AppResponse(false, statusCode, {});
  }

  Future<AppResponse<dynamic>> getRateOptions() async {
    CustomLoader.show();
    Response response = await locator<SavingsRepositoryImpl>().getRateOptions();
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }

    return AppResponse(false, statusCode, {});
  }
}
