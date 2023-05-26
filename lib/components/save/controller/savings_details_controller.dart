import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/components/save/model/savings_model.dart';
import 'package:sprout_mobile/utils/app_formatter.dart';

class SavingsDetailsController extends GetxController {
  final storage = GetStorage();
  final AppFormatter formatter = Get.put(AppFormatter());

  // arguments
  var args;
  var savings = Rxn<Savings>();

  RxBool loading = false.obs;
  RxBool isChecked = false.obs;

  @override
  void onInit() {
    storage.remove("removeAll");
    super.onInit();
    args = Get.arguments;
    savings.value = args;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    storage.write('removeAll', "1");
    super.onClose();
  }
}
