import 'package:dio/dio.dart';

import 'package:sprout_mobile/api/api_response.dart';
import '../../../api-setup/api_setup.dart';
import '../../../public/widgets/custom_loader.dart';
import '../repository/complete_account_setup_repositoryimpl.dart';

class CompleteAccountSetupService {
  Future<AppResponse<dynamic>> requestVerification(
      Map<String, dynamic> requestBody) async {
    CustomLoader.show();
    Response response = await locator
        .get<CompleteAccountSetupRepositoryImpl>()
        .requestVerification(requestBody);
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
