import 'package:get/get.dart';
import 'package:sprout_mobile/api-setup/api_setup.dart';
import 'package:sprout_mobile/public/services/shared_service.dart';

class PaymentLinkSuccessController extends GetxController {
  var args;
  var paymentLink = Rxn<dynamic>();
  RxString paymentName = "".obs;
  @override
  void onInit() {
    super.onInit();
    args = Get.arguments;
    paymentLink.value = args["data"];
    paymentName.value = args["name"];
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
