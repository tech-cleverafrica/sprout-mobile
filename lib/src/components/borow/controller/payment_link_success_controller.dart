import 'package:get/get.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/public/services/shared_service.dart';

class PaymentLinkSuccessController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  showUpdateModal(context, isDarkMode) {}

  Future share(String text) async {
    try {
      await locator.get<SharedService>().shareText(text);
    } catch (e) {
      print(e);
    }
  }
}
