import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_model.dart';
import 'package:sprout_mobile/src/components/invoice/service/invoice_service.dart';

import '../../../api-setup/api_setup.dart';
import '../../../api/api_response.dart';

class InvoiceController extends GetxController {
  RxList<InvoiceRespose> invoiceResponse = <InvoiceRespose>[].obs;
  RxList<Invoice> invoice = <Invoice>[].obs;
  RxBool isInvoiceLoading = false.obs;

  @override
  void onInit() {
    fetchUserInvoices();
    super.onInit();
  }

  fetchUserInvoices() async {
    isInvoiceLoading.value = true;
    AppResponse<List<Invoice>> invoiceResponse =
        await locator.get<InvoiceService>().getInvoices();
    isInvoiceLoading.value = false;

    if (invoiceResponse.status) {
      invoice.assignAll(invoiceResponse.data!);
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
