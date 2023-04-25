import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/borow/model/payment_link_model.dart';

class PaymentLinkDetailsController extends GetxController {
  var args;
  var paymentLink = Rxn<PaymentLink>();
  RxDouble amountDue = 0.0.obs;
  RxBool loading = false.obs;
  RxString screenStatus = "".obs;

  @override
  void onInit() {
    super.onInit();
    args = Get.arguments;
    paymentLink.value = args;
    print(paymentLink.value!.fullName!);
    setStatus();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  setStatus() {
    if (paymentLink.value?.paid == true) {
      screenStatus.value = "Paid";
    } else {
      screenStatus.value = "Not Paid";
    }
  }
}
