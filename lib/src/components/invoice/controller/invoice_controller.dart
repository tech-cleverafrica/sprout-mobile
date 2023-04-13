import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_customer_model.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_detail_model.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_model.dart';
import 'package:sprout_mobile/src/components/invoice/service/invoice_service.dart';
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

  final TextEditingController updateCustomerNameController =
      new TextEditingController();
  final TextEditingController updateCustomerPhoneController =
      new TextEditingController();
  final TextEditingController updateCustomerEmailController =
      new TextEditingController();
  final TextEditingController updateCustomerAddressController =
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
    if (updateCustomerNameController.text.isEmpty ||
        updateCustomerAddressController.text.isEmpty ||
        updateCustomerEmailController.text.isEmpty ||
        updateCustomerPhoneController.text.isEmpty) {
      CustomToastNotification.show("Please supply new details to upload",
          type: ToastType.error);
    } else {
      updateCustomer(id);
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 25.h,
                        ),
                        Center(
                          child: Text(
                            "Update Customer info",
                            style: TextStyle(
                                fontFamily: "Outfit",
                                fontSize: 15.sp,
                                color: AppColors.black),
                          ),
                        ),
                        CustomTextFormField(
                          controller: updateCustomerNameController,
                          label: "Customer Name",
                          hintText: fullName,
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                        ),
                        CustomTextFormField(
                          controller: updateCustomerPhoneController,
                          label: "Phone Number",
                          textInputType: TextInputType.phone,
                          hintText: phone,
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                        ),
                        CustomTextFormField(
                          controller: updateCustomerEmailController,
                          label: "Email",
                          textInputType: TextInputType.emailAddress,
                          hintText: email,
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                        ),
                        CustomTextFormField(
                          controller: updateCustomerAddressController,
                          label: "Address",
                          hintText: address,
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                        ),
                        addVerticalSpace(40.h),
                        CustomButton(
                          title: "Update Customer",
                          borderRadius: 30,
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
