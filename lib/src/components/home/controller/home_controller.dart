import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isInvoice = false.obs;

  void toggleDisplay() => isInvoice.value = isInvoice.value ? false : true;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
