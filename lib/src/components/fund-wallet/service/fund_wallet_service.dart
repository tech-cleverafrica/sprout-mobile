import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/components/fund-wallet/model/customer_card_model.dart';
import 'package:sprout_mobile/src/components/fund-wallet/repository/fund_wallet_repositoryImpl.dart';
import 'package:sprout_mobile/src/public/widgets/custom_loader.dart';

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

  Future<AppResponse<List<CustomerCard>>> getCards() async {
    Response response = await locator<FundWalletRepositoryImpl>().getCards();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = {"data": response.data};
    if (statusCode >= 200 && statusCode <= 300) {
      print(":::::::::$responseBody");
      return AppResponse<List<CustomerCard>>(true, statusCode, responseBody,
          CustomerCard.getList(responseBody['data']));
    }
    return AppResponse(false, statusCode, responseBody);
  }

  Future<AppResponse<dynamic>> fundWalletWithNewCard(
      Map<String, dynamic> requestBody) async {
    CustomLoader.show();
    Response response = await locator<FundWalletRepositoryImpl>()
        .fundWalletWithNewCard(requestBody);
    CustomLoader.dismiss();
    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (response.statusCode == 200) {
      print(":::::::::$responseBody");
      return AppResponse<dynamic>(true, statusCode, responseBody, responseBody);
    }
    return AppResponse(false, statusCode, responseBody);
  }
}
