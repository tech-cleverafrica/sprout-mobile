import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_customer_model.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_detail_model.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_model.dart';
import 'package:sprout_mobile/src/components/invoice/service/invoice_service.dart';
import 'package:sprout_mobile/src/components/authentication/service/auth_service.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_formatter.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../../api-setup/api_setup.dart';
import '../../../api/api_response.dart';
import '../../../public/widgets/custom_button.dart';
import '../../../public/widgets/custom_text_form_field.dart';
import '../../../public/widgets/custom_toast_notification.dart';
import '../../../utils/helper_widgets.dart';

class InvoiceController extends GetxController {
  final AppFormatter formatter = Get.put(AppFormatter());
  TextEditingController searchController = new TextEditingController();

  TextEditingController updateCustomerNameController =
      new TextEditingController();
  TextEditingController updateCustomerPhoneController =
      new TextEditingController();
  TextEditingController updateCustomerEmailController =
      new TextEditingController();
  TextEditingController updateCustomerAddressController =
      new TextEditingController();

  RxList<InvoiceRespose> invoiceResponse = <InvoiceRespose>[].obs;
  RxList<Invoice> invoice = <Invoice>[].obs;
  RxList<Invoice> baseInvoice = <Invoice>[].obs;

  RxList<InvoiceCustomerResponse> invoiceCustomerResponse =
      <InvoiceCustomerResponse>[].obs;
  RxList<InvoiceCustomer> invoiceCustomer = <InvoiceCustomer>[].obs;
  RxList<InvoiceCustomer> baseInvoiceCustomer = <InvoiceCustomer>[].obs;

  InvoiceDetail? invoiceDetail;
  RxBool isInvoiceLoading = false.obs;
  RxBool isInvoiceCustomerLoading = false.obs;
  RxBool isSingleInvoiceLoading = false.obs;
  RxBool isInvoiceDisplay = true.obs;
  RxBool showMain = false.obs;

  @override
  void onInit() {
    fetchUserInvoices();
    fetchInvoiceCustomers();
    super.onInit();
  }

  fetchUserInvoices() async {
    isInvoiceLoading.value = true;
    AppResponse<List<Invoice>> invoiceResponse =
        await locator.get<InvoiceService>().getInvoices();
    isInvoiceLoading.value = false;
    if (invoiceResponse.status) {
      invoice.assignAll(invoiceResponse.data!);
      baseInvoice.assignAll(invoiceResponse.data!);
      debugPrint("the invoices are ::::::::::::::::::::$invoice");
    } else if (invoiceResponse.statusCode == 999) {
      AppResponse res = await locator<AuthService>().refreshUserToken();
      if (res.status) {
        fetchUserInvoices();
      }
    }
  }

  Future<dynamic> fetchInvoiceCustomers() async {
    isInvoiceCustomerLoading.value = true;
    AppResponse<List<InvoiceCustomer>> invoiceCustomerResponse =
        await locator.get<InvoiceService>().getInvoiceCustomer();
    isInvoiceCustomerLoading.value = false;
    if (invoiceCustomerResponse.status) {
      invoiceCustomer.assignAll(invoiceCustomerResponse.data!);
      baseInvoiceCustomer.assignAll(invoiceCustomerResponse.data!);
      debugPrint(
          "the invoice customers are ::::::::::::::::::::$invoiceCustomer");
      return true;
    } else if (invoiceCustomerResponse.statusCode == 999) {
      AppResponse res = await locator<AuthService>().refreshUserToken();
      if (res.status) {
        fetchInvoiceCustomers();
      }
    }
    return null;
  }

  fetchSingleInvoice(String invoiceId) async {
    isSingleInvoiceLoading.value = true;
    AppResponse appResponse =
        await locator.get<InvoiceService>().getInvoice(invoiceId);
    isSingleInvoiceLoading.value = false;
    debugPrint("the invoice is  ::::::::::::::::::::${appResponse.data}");

    if (appResponse.status) {
      invoiceDetail = InvoiceDetail.fromJson(appResponse.data['data']);

      debugPrint(
          "processed invoice is  ::::::::::::::::::::${json.encode(invoiceDetail)}");
    }
  }

  buildCustomerRequest() {
    return {
      "fullName": updateCustomerNameController.text,
      "email": updateCustomerEmailController.text,
      "address": updateCustomerAddressController.text,
      "phone": updateCustomerPhoneController.text
    };
  }

  validateCustomerUpdate(String id) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (updateCustomerNameController.text.length > 1 &&
        updateCustomerPhoneController.text.length == 11 &&
        updateCustomerEmailController.text.isNotEmpty &&
        updateCustomerAddressController.text.length > 5 &&
        (regex.hasMatch(updateCustomerEmailController.text))) {
      updateCustomer(id);
    } else if (updateCustomerNameController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Customer Name is required"),
          backgroundColor: AppColors.errorRed));
    } else if (updateCustomerNameController.text.length < 2) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Customer Name is too short"),
          backgroundColor: AppColors.errorRed));
    } else if (updateCustomerPhoneController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Phone number is required"),
          backgroundColor: AppColors.errorRed));
    } else if (updateCustomerPhoneController.text.length < 11) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Phone number should ber 11 digits"),
          backgroundColor: AppColors.errorRed));
    } else if (updateCustomerEmailController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Email is required"),
          backgroundColor: AppColors.errorRed));
    } else if (!(regex.hasMatch(updateCustomerEmailController.text))) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please enter a valid email"),
          backgroundColor: AppColors.errorRed));
    } else if (updateCustomerAddressController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Address is required"),
          backgroundColor: AppColors.errorRed));
    } else if (updateCustomerAddressController.text.length < 6) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Address is too short"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required fields"),
          backgroundColor: AppColors.errorRed));
    }
  }

  updateCustomer(String customerId) async {
    AppResponse appResponse = await locator
        .get<InvoiceService>()
        .updateCustomer(buildCustomerRequest(), customerId);
    if (appResponse.status) {
      debugPrint(appResponse.message);
      CustomToastNotification.show(appResponse.message,
          type: ToastType.success);
      pop();
      fetchInvoiceCustomers();
    } else {
      CustomToastNotification.show(appResponse.message, type: ToastType.error);
    }
  }

  filterInvoices(String value) {
    invoice.value = value == ""
        ? baseInvoice
        : baseInvoice
            .where((i) =>
                i.invoiceNo!.toLowerCase().contains(value.toLowerCase()) ||
                i.customer!.fullName!
                    .toLowerCase()
                    .contains(value.toLowerCase()) ||
                i.businessInfo!.businessName!
                    .toLowerCase()
                    .contains(value.toLowerCase()))
            .toList();
  }

  filterCustomers(String value) {
    invoiceCustomer.value = value == ""
        ? baseInvoiceCustomer
        : baseInvoiceCustomer
            .where(
                (i) => i.fullName!.toLowerCase().contains(value.toLowerCase()))
            .toList();
  }

  reset() {
    searchController = new TextEditingController(text: "");
    invoice.value = baseInvoice;
    invoiceCustomer.value = baseInvoiceCustomer;
  }

  showUpdateModal(context, isDarkMode, String id, String fullName, String phone,
      String email, String address) {
    updateCustomerNameController = new TextEditingController(text: fullName);
    updateCustomerPhoneController = new TextEditingController(text: phone);
    updateCustomerEmailController = new TextEditingController(text: email);
    updateCustomerAddressController = new TextEditingController(text: address);
    showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.7,
            child: StatefulBuilder(builder: (BuildContext context,
                StateSetter setModalState /*You can rename this!*/) {
              return Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 25.h,
                        ),
                        Center(
                          child: Text(
                            "Update Customer info",
                            style: TextStyle(
                                fontFamily: "Mont",
                                fontSize: 14.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        CustomTextFormField(
                          controller: updateCustomerNameController,
                          label: "Customer Name",
                          hintText: "Enter Customer Name",
                          textInputAction: TextInputAction.next,
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                          validator: (value) {
                            if (value!.length == 0)
                              return "Customer Name is required";
                            else if (value.length < 2)
                              return "Customer Name is too short";
                            return null;
                          },
                        ),
                        CustomTextFormField(
                            controller: updateCustomerPhoneController,
                            label: "Phone Number",
                            hintText: "Enter Phone Number",
                            maxLength: 11,
                            showCounterText: false,
                            maxLengthEnforced: true,
                            fillColor: isDarkMode
                                ? AppColors.inputBackgroundColor
                                : AppColors.grey,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^[0-9]*$'))
                            ],
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.phone,
                            validator: (value) {
                              if (value!.length == 0)
                                return "Phone number is required";
                              else if (value.length < 11)
                                return "Phone number should be 11 digits";
                              return null;
                            }),
                        CustomTextFormField(
                          controller: updateCustomerEmailController,
                          label: "Email",
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                          hintText: "davejossy9@gmail.com",
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                          validator: (value) =>
                              EmailValidator.validate(value ?? "")
                                  ? null
                                  : "Please enter a valid email",
                        ),
                        CustomTextFormField(
                          controller: updateCustomerAddressController,
                          maxLines: 2,
                          maxLength: 250,
                          label: "Enter Address",
                          hintText: "Address",
                          maxLengthEnforced: true,
                          validator: (value) {
                            if (value!.length == 0)
                              return "Address is required";
                            else if (value.length < 6)
                              return "Address is too short";
                            return null;
                          },
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                        ),
                        addVerticalSpace(40.h),
                        CustomButton(
                          title: "Update Customer",
                          onTap: () {
                            debugPrint(id);
                            validateCustomerUpdate(id);
                          },
                        ),
                        SizedBox(
                          height: 36.h,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        });
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
