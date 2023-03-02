import 'package:get/get.dart';

import '../../../repository/preference_repository.dart';

class HomeController extends GetxController {
  RxBool isInvoice = false.obs;

  late String fullname;

  final PreferenceRepository preferenceRepository =
      Get.put(PreferenceRepository());

  void toggleDisplay() => isInvoice.value = isInvoice.value ? false : true;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit()async {
    fullname = await preferenceRepository.getStringPref("fullname");
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
