import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/pay-bills/model/biller_model.dart';
import 'package:sprout_mobile/src/components/pay-bills/service/pay_bills_service.dart';

import '../../../api-setup/api_setup.dart';
import '../../../api/api_response.dart';

class AirtimeController extends GetxController {
  var localeBiller = Rxn<Biller>();
  RxList<Biller> billers = <Biller>[].obs;
  List<Biller> baseBillers = <Biller>[];
  RxBool loading = false.obs;

  @override
  void onInit() {
    getBillers();
    super.onInit();
  }

  getBillers() async {
    loading.value = true;
    AppResponse<List<Biller>> response =
        await locator.get<PayBillsService>().getBillers("airtime/biller");
    loading.value = false;
    if (response.status) {
      billers.assignAll(response.data);
      baseBillers.assignAll(response.data);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
