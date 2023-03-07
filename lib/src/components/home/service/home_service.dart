import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/components/home/controller/home_controller.dart';
import 'package:sprout_mobile/src/components/home/model/transactions_model.dart';
import 'package:sprout_mobile/src/components/home/model/wallet_model.dart';
import 'package:sprout_mobile/src/components/home/repository/home_repositoryImpl.dart';

import '../../../api-setup/api_setup.dart';
import '../../../api/api.dart';
import 'package:get/get.dart' as get_accessor;

import '../../../api/api_response.dart';
import '../../../public/widgets/custom_loader.dart';
import '../../../reources/repository.dart';
import '../../../repository/preference_repository.dart';

class HomeService {
  final Api api = get_accessor.Get.put(Api(Dio()));
  final Repository repository = get_accessor.Get.put(Repository());
  final storage = GetStorage();
  final PreferenceRepository preferenceRepository =
      get_accessor.Get.put(PreferenceRepository());

  Future<AppResponse<dynamic>> getWallet() async {
    CustomLoader.show(message: "Getting balances ...");
    Response response = await locator<HomeRepositoryImpl>().getWallet();
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;

    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      Wallet wallet = Wallet.fromJson(response.data);
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }

    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<List<Transactions>>> getTransaction() async {
    Response response = await locator<HomeRepositoryImpl>().getTransactions();

    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<List<Transactions>>(true, statusCode, responseBody,
          Transactions.getList(responseBody["data"]));
    }

    return AppResponse(false, statusCode, {});
  }
}
