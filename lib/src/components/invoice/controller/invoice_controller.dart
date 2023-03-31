import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_customer_model.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_detail_model.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_model.dart';
import 'package:sprout_mobile/src/components/invoice/service/invoice_service.dart';

import '../../../api-setup/api_setup.dart';
import '../../../api/api_response.dart';

class InvoiceController extends GetxController {
  RxList<InvoiceRespose> invoiceResponse = <InvoiceRespose>[].obs;
  RxList<Invoice> invoice = <Invoice>[].obs;

  RxList<InvoiceCustomerResponse> invoiceCustomerResponse =
      <InvoiceCustomerResponse>[].obs;
  RxList<InvoiceCustomer> invoiceCustomer = <InvoiceCustomer>[].obs;

  InvoiceDetail? invoiceDetail;
  RxBool isInvoiceLoading = false.obs;
  RxBool isInvoiceCustomerLoading = false.obs;
  RxBool isSingleInvoiceLoading = false.obs;

  RxBool isInvoiceDisplay = true.obs;

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
      //  debugPrint("the invoices are ::::::::::::::::::::$invoice");
    }
  }

  fetchInvoiceCustomers() async {
    isInvoiceCustomerLoading.value = true;
    AppResponse<List<InvoiceCustomer>> invoiceCustomerResponse =
        await locator.get<InvoiceService>().getInvoiceCustomer();
    isInvoiceCustomerLoading.value = false;

    if (invoiceCustomerResponse.status) {
      invoiceCustomer.assignAll(invoiceCustomerResponse.data!);
      debugPrint(
          "the invoice customers are ::::::::::::::::::::$invoiceCustomer");
    }
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
