import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/api/api.dart';
import 'package:sprout_mobile/src/api/api_constant.dart';
import 'package:sprout_mobile/src/components/pay-bills/repository/pay_bills_repository.dart';

class PayBillsRepositoryImpl implements PayBillsRepository {
  final Api api = Get.find<Api>();
  final storage = GetStorage();

  @override
  getBillerGroups() async {
    try {
      return await api.dio.get(billerGroupsUrl);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  getBillers(String route) async {
    try {
      return await api.dio.get(billsUrl + route);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  getPackages(Map<String, dynamic> requestBody, String route) async {
    try {
      return await api.dio.post(billsUrl + route, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  lookup(Map<String, dynamic> requestBody, String route) async {
    try {
      return await api.dio.post(billsUrl + route, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }

  @override
  makePayment(Map<String, dynamic> requestBody, String route) async {
    try {
      return await api.dio.post(billsUrl + route, data: requestBody);
    } on DioError catch (e) {
      return api.handleError(e);
    } catch (e) {
      e.printError();
    }
  }
}
