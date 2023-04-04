import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/components/fund-wallet/repository/fund_wallet_repositoryImpl.dart';

import '../../../api-setup/api_setup.dart';
import '../../../api/api.dart';
import 'package:get/get.dart' as get_accessor;

import '../../../api/api_response.dart';
import '../../../reources/repository.dart';
import '../../../repository/preference_repository.dart';

class FundWalletService {
  final Api api = get_accessor.Get.put(Api(Dio()));
  final Repository repository = get_accessor.Get.put(Repository());
  final storage = GetStorage();
  final PreferenceRepository preferenceRepository =
      get_accessor.Get.put(PreferenceRepository());
  Future<AppResponse<dynamic>> getCards() async {
    Response response = await locator<FundWalletRepositoryImpl>().getCards();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (response.data["status"]) {
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }
}
