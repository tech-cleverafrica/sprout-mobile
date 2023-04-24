import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/components/home/model/transactions_model.dart';
import 'package:sprout_mobile/src/components/home/repository/home_repositoryImpl.dart';
import 'package:sprout_mobile/src/public/widgets/custom_loader.dart';

import '../../../api-setup/api_setup.dart';
import '../../../api/api.dart';
import 'package:get/get.dart' as get_accessor;

import '../../../api/api_response.dart';
import '../../../reources/repository.dart';
import '../../../repository/preference_repository.dart';

class HomeService {
  final Api api = get_accessor.Get.put(Api(Dio()));
  final Repository repository = get_accessor.Get.put(Repository());
  final storage = GetStorage();
  final PreferenceRepository preferenceRepository =
      get_accessor.Get.put(PreferenceRepository());
  Future<AppResponse<dynamic>> getWallet() async {
    Response response = await locator.get<HomeRepositoryImpl>().getWallet();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<List<Transactions>>> getTransactions() async {
    Response response =
        await locator.get<HomeRepositoryImpl>().getTransactions();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<List<Transactions>>(true, statusCode, responseBody,
          Transactions.getList(responseBody["data"]));
    }
    return AppResponse(false, statusCode, {});
  }

  Future<AppResponse<List<Transactions>>> getTransactionsWithFilter(
      String filters) async {
    Response response = await locator
        .get<HomeRepositoryImpl>()
        .getTransactionsWithFilter(filters);
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<List<Transactions>>(true, statusCode, responseBody,
          Transactions.getList(responseBody["data"]));
    }
    return AppResponse(false, statusCode, {});
  }

  Future<AppResponse<dynamic>> downloadTransactionRecords(
      String filters) async {
    CustomLoader.show();
    Response response = await locator
        .get<HomeRepositoryImpl>()
        .downloadTransactionRecords(filters);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, {});
  }

  Future<AppResponse<Transactions>> getTransaction(String slug) async {
    Response response =
        await locator.get<HomeRepositoryImpl>().getTransaction(slug);
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<Transactions>(true, statusCode, responseBody,
          Transactions.fromJson(responseBody["data"]));
    }
    return AppResponse(false, statusCode, {});
  }

  Future<AppResponse<dynamic>> getDashboardGraph() async {
    Response response =
        await locator.get<HomeRepositoryImpl>().getDashboardGraph();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, {});
  }
}
