import 'package:get/get.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/components/home/model/transactions_model.dart';
import 'package:sprout_mobile/src/components/send-money/model/bank_beneficiary.dart';
import 'package:sprout_mobile/src/components/send-money/service/send_money_service.dart';

import '../../../api/api_response.dart';

class SendMoneyController extends GetxController {
  RxList<BeneficiaryResponse> beneficiaryResponse = <BeneficiaryResponse>[].obs;
  RxList<Beneficiary> beneficiary = <Beneficiary>[].obs;
  RxBool isBeneficiaryLoading = false.obs;

  @override
  void onInit() {
    loadBeneficiary();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  loadBeneficiary() async {
    isBeneficiaryLoading.value = true;
    AppResponse<List<Beneficiary>> beneficiaryResponse =
        await locator.get<SendMoneyService>().getBeneficiary();
    isBeneficiaryLoading.value = false;

    if (beneficiaryResponse.status) {
      beneficiary.assignAll(beneficiaryResponse.data!);
      print(beneficiaryResponse);
    }
  }
}
