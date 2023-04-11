import 'package:dio/dio.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/send-money/model/bank_beneficiary.dart';
import 'package:sprout_mobile/src/components/send-money/model/banks.dart';
import 'package:sprout_mobile/src/components/send-money/repository/send_money_repository.dart';
import '../../../public/widgets/custom_loader.dart';

class SendMoneyService {
  Future<AppResponse<List<Beneficiary>>> getBeneficiary() async {
    CustomLoader.show();
    Response response =
        await locator<SendMoneyRepositoryImpl>().getBeneficiaries();
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<List<Beneficiary>>(true, statusCode, responseBody,
          Beneficiary.getList(responseBody["data"]));
    }

    return AppResponse(false, statusCode, {});
  }

  Future<AppResponse<dynamic>> getBanks() async {
    Response response = await locator<SendMoneyRepositoryImpl>().getBanks();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;

    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      Banks banks = Banks.fromJson(responseBody["data"]);
      print("This is bannnnnnnnnnnnnnnnnnnnnnnnnkks:::::$banks");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> validateBank(
      Map<String, dynamic> requestBody) async {
    Response response =
        await locator<SendMoneyRepositoryImpl>().validateBank(requestBody);
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> makeTransfer(
      Map<String, dynamic> requestBody) async {
    CustomLoader.show();
    Response response =
        await locator<SendMoneyRepositoryImpl>().makeTransfer(requestBody);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> addBeneficiary(
      Map<String, dynamic> requestBody) async {
    Response response =
        await locator<SendMoneyRepositoryImpl>().addBeneficiary(requestBody);
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }
}
