import 'package:get/get.dart';
import 'package:sprout_mobile/components/pay-bills/model/biller_model.dart';
import 'package:sprout_mobile/components/pay-bills/service/pay_bills_service.dart';
import 'package:sprout_mobile/components/authentication/service/auth_service.dart';
import 'package:sprout_mobile/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/utils/nav_function.dart';

import '../../../api-setup/api_setup.dart';
import '../../../api/api_response.dart';

class BillersController extends GetxController {
  String group = "";
  RxList<Biller> billers = <Biller>[].obs;
  List<Biller> baseBillers = <Biller>[];
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    group = Get.arguments;
    getBillers();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getBillers() async {
    loading.value = true;
    String route = buildRoute();
    AppResponse<List<Biller>> response =
        await locator.get<PayBillsService>().getBillers(route);
    loading.value = false;
    if (response.status) {
      billers.assignAll(response.data!);
      baseBillers.assignAll(response.data);
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        getBillers();
      }
    } else {
      pop();
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  filterBillers(String value) {
    billers.value = value == ""
        ? baseBillers
        : baseBillers
            .where((i) => i.name!.toLowerCase().contains(value.toLowerCase()))
            .toList();
  }

  String buildRoute() {
    switch (group) {
      case "ELECTRIC_DISCO":
        return "discos/biller";
      case "DISCO":
        return "discos/biller";
      case "PAID_TV":
        return "cables/biller";
      case "PAY_TV":
        return "cables/biller";
      case "AIRTIME_AND_DATA":
        return "data/biller";
      case "BETTING_AND_LOTTERY":
        return "bettings/biller";
      case "TRANSPORT_AND_TOLL_PAYMENT":
        return "utilitypayments/biller";
    }
    return "";
  }
}
