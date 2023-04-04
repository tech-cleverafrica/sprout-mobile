import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/invoice/controller/invoice_controller.dart';
import 'package:sprout_mobile/src/components/invoice/service/invoice_service.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../../api-setup/api_setup.dart';
import '../../../api/api_response.dart';
import '../../../public/widgets/custom_toast_notification.dart';
import '../../../utils/app_colors.dart';

class CustomerController extends GetxController {
  final TextEditingController customerNameController =
      new TextEditingController();
  final TextEditingController customerPhoneController =
      new TextEditingController();
  final TextEditingController customerEmailController =
      new TextEditingController();
  final TextEditingController customerAddressController =
      new TextEditingController();

  late InvoiceController invoiceController;

  validate() {
    if (customerNameController.text.isEmpty ||
        customerAddressController.text.isEmpty ||
        customerEmailController.text.isEmpty ||
        customerPhoneController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required inputs"),
          backgroundColor: AppColors.errorRed));
    } else {
      addCustomer();
    }
  }

  buildCustomerRequest() {
    return {
      "fullName": customerNameController.text,
      "email": customerEmailController.text,
      "address": customerAddressController.text,
      "phone": customerPhoneController.text
    };
  }

  addCustomer() async {
    AppResponse appResponse = await locator
        .get<InvoiceService>()
        .addCustomer(buildCustomerRequest(), "Adding customer...");
    if (appResponse.status) {
      debugPrint(appResponse.message);
      CustomToastNotification.show(appResponse.message,
          type: ToastType.success);
      pop();
      invoiceController.fetchInvoiceCustomers();
    } else {
      CustomToastNotification.show(appResponse.message, type: ToastType.error);
    }
  }

  @override
  void onInit() {
    invoiceController = Get.put(InvoiceController());
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
}
