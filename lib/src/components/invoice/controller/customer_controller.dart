import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/invoice/controller/invoice_controller.dart';
import 'package:sprout_mobile/src/components/invoice/service/invoice_service.dart';
import 'package:sprout_mobile/src/components/authentication/service/auth_service.dart';
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
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (customerNameController.text.length > 1 &&
        customerPhoneController.text.length == 11 &&
        customerEmailController.text.isNotEmpty &&
        customerAddressController.text.length > 5 &&
        (regex.hasMatch(customerEmailController.text))) {
      addCustomer();
    } else if (customerNameController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Customer Name is required"),
          backgroundColor: AppColors.errorRed));
    } else if (customerNameController.text.length < 2) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Customer Name is too short"),
          backgroundColor: AppColors.errorRed));
    } else if (customerPhoneController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Phone number is required"),
          backgroundColor: AppColors.errorRed));
    } else if (customerPhoneController.text.length < 11) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Phone number should ber 11 digits"),
          backgroundColor: AppColors.errorRed));
    } else if (customerEmailController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Email is required"),
          backgroundColor: AppColors.errorRed));
    } else if (!(regex.hasMatch(customerEmailController.text))) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please enter a valid email"),
          backgroundColor: AppColors.errorRed));
    } else if (customerAddressController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Address is required"),
          backgroundColor: AppColors.errorRed));
    } else if (customerAddressController.text.length < 6) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Address is too short"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required fields"),
          backgroundColor: AppColors.errorRed));
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
    AppResponse appResponse =
        await locator.get<InvoiceService>().addCustomer(buildCustomerRequest());
    if (appResponse.status) {
      CustomToastNotification.show(appResponse.message,
          type: ToastType.success);
      pop();
      invoiceController.fetchInvoiceCustomers();
    } else if (appResponse.statusCode == 999) {
      AppResponse res = await locator<AuthService>().refreshUserToken();
      if (res.status) {
        addCustomer();
      }
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
