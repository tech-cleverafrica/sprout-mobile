import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_model.dart';

class InvoiceSuccessController extends GetxController {
  var args;
  var invoice = Rxn<Invoice>();

  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    args = Get.arguments;
    invoice.value = Invoice.fromJson(args);
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
