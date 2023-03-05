import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:basic_utils/basic_utils.dart';

class HomeController extends GetxController {
  final storage = GetStorage();
  RxBool isInvoice = false.obs;
  String fullname = "";

  void toggleDisplay() => isInvoice.value = isInvoice.value ? false : true;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() async {
    fullname = StringUtils.capitalize(storage.read("firstname"));
    debugPrint("the firstname is $fullname");
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
