import 'package:dio/dio.dart';

import 'package:sprout_mobile/src/api/api_response.dart';
import '../../../api-setup/api_setup.dart';
import '../../../public/widgets/custom_loader.dart';
import '../repository/complete_account_setup_repositoryimpl.dart';

class CompleteAccountSetupService {
  Future<AppResponse<dynamic>> requestVerification(
      Map<String, dynamic> requestBody, String loadingMessage) async {
    CustomLoader.show(message: loadingMessage);
    Response response = await locator<CompleteAccountSetupRepositoryImpl>()
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
