import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/api/api.dart';
import 'package:sprout_mobile/api/api_constant.dart';
import 'package:sprout_mobile/components/send-money/repository/send_money_repository_impl.dart';

class SendMoneyRepositoryImpl implements SendMoneyRepository {
  final Api api = Get.find<Api>();
  @override
  getBeneficiaries() async {
    try {
      return await api.dio.get(
        beneficiaryUrl,
      );
    } on DioError catch (e) {
      return api.handleError(e);
    }
  }

  @override
  getBanks() async {
    try {
      return await api.dio.get(
        banksUrl,
      );
    } on DioError catch (e) {
      return api.handleError(e);
    }
  }

  @override
  validateBank(requestBody) async {
    try {
      return await api.dio.post(validateBankUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  makeTransfer(requestBody) async {
    try {
      return await api.dio.post(makeTransferUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  addBeneficiary(requestBody) async {
    try {
      return await api.dio.post(addBeneficiaryUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  getFxRates() async {
    try {
      return await api.dio.get(
        fxRatesUrl,
      );
    } on DioError catch (e) {
      return api.handleError(e);
    }
  }

  @override
  makeFxTransfer(requestBody) async {
    try {
      return await api.dio.post(fxTransferUrl, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }
}
