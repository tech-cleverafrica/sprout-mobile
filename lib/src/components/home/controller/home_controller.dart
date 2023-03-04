import 'package:get/get.dart';

import '../../../repository/preference_repository.dart';

class HomeController extends GetxController {
  RxBool isInvoice = false.obs;

  String? fullname;

  void toggleDisplay() => isInvoice.value = isInvoice.value ? false : true;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
