import 'package:dio/dio.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/send-money/model/bank_beneficiary.dart';
import 'package:sprout_mobile/src/components/send-money/repository/send_money_repository.dart';
import 'package:sprout_mobile/src/repository/preference_repository.dart';
import 'package:get/get.dart' as get_accessor;
import '../../../reources/repository.dart';

class SendMoneyService {
  final Api api = get_accessor.Get.put(Api(Dio()));
  final Repository repository = get_accessor.Get.put(Repository());

  final PreferenceRepository preferenceRepository =
      get_accessor.Get.put(PreferenceRepository());

  Future<AppResponse<List<Beneficiary>>> getBeneficiary() async {
    Response response =
        await locator<SendMoneyRepositoryImpl>().getBeneficiaries();

    int statusCode = response.statusCode ?? 000;
    Map<String, dynamic> responseBody = response.data;
    if (statusCode >= 200 && statusCode <= 300) {
      print("vvv$responseBody");
      return AppResponse<List<Beneficiary>>(true, statusCode, responseBody,
          Beneficiary.getList(responseBody["data"]));
    }

    return AppResponse(false, statusCode, {});
  }
}
