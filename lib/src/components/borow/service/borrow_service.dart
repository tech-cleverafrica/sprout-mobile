import 'package:dio/dio.dart';

import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/borow/model/payment_link_model.dart';
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

  Future<AppResponse<List<PaymentLink>>> getPaymentLinks() async {
    CustomLoader.show();
    Response response =
        await locator.get<BorrowRepositoryImpl>().getPaymentLinks();
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<List<PaymentLink>>(true, statusCode, responseBody,
          PaymentLink.getList(responseBody["data"]));
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> createPaymentLink(
      Map<String, dynamic> requestBody) async {
    CustomLoader.show();
    Response response = await locator
        .get<BorrowRepositoryImpl>()
        .createPaymentLink(requestBody);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<PaymentLink>> getPaymentLink(String id) async {
    CustomLoader.show();
    Response response =
        await locator.get<BorrowRepositoryImpl>().getPaymentLink(id);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<PaymentLink>(
          true, statusCode, responseBody, responseBody["data"]);
    }
    return AppResponse(false, statusCode, responseBody);
  }
}
