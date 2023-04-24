import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/pay-bills/model/biller_group_model.dart';
import 'package:sprout_mobile/src/components/pay-bills/service/pay_bills_service.dart';
import 'package:sprout_mobile/src/components/authentication/service/auth_service.dart';

import '../../../api-setup/api_setup.dart';
import '../../../api/api_response.dart';

class PayBillsController extends GetxController {
  RxList<BillerGroup> groups = <BillerGroup>[].obs;
  List<BillerGroup> baseGroups = <BillerGroup>[];
  RxBool loading = false.obs;

  @override
  void onInit() {
    getBillerGroups();
    super.onInit();
  }

  getBillerGroups() async {
    loading.value = true;
    AppResponse<List<BillerGroup>> response =
        await locator.get<PayBillsService>().getBillerGroups();
    loading.value = false;
    if (response.status) {
      groups.assignAll(response.data!);
      baseGroups.assignAll(response.data);
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        getBillerGroups();
      }
    }
  }

  filterGroups(String value) {
    groups.value = value == ""
        ? baseGroups
        : baseGroups.where((i) => i.name!.contains(value)).toList();
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
