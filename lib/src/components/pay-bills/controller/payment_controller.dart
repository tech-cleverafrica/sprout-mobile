import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/pay-bills/controller/billers_controller.dart';
import 'package:sprout_mobile/src/components/pay-bills/controller/packages_controller.dart';

class PaymentController extends GetxController {
  final BillersController billersController = Get.put(BillersController());
  final PackagesController packagesController = Get.put(PackagesController());

  // arguments
  var args;
  var customer = Rxn<dynamic>();

  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    args = Get.arguments;
    customer.value = args;
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
