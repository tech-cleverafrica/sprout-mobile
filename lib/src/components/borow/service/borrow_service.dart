import 'package:dio/dio.dart';

import 'package:sprout_mobile/src/api/api_response.dart';
import '../../../api-setup/api_setup.dart';
import '../../../public/widgets/custom_loader.dart';
import '../repository/borrow_repositoryimpl.dart';

class BorrowService {
  Future<AppResponse<dynamic>> initiateCardlessPayment(
      Map<String, dynamic> requestBody) async {
    CustomLoader.show();
    Response response = await locator
        .get<BorrowRepositoryImpl>()
        .initiateCardlessPayment(requestBody);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> saveCardlessPayment(
      Map<String, dynamic> requestBody) async {
    CustomLoader.show();
    Response response = await locator
        .get<BorrowRepositoryImpl>()
        .saveCardlessPayment(requestBody);
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
