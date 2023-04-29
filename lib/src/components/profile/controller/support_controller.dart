import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SupportController extends GetxController {
  final storage = GetStorage();

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
    storage.write('removeAll', "1");
    super.onClose();
  }
}
